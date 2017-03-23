package com.db.tourist.services.Impl;

import com.db.tourist.models.*;
import com.db.tourist.models.Object;
import com.db.tourist.repositories.ObjectRepository;
import com.db.tourist.repositories.PhotoRepository;
import com.db.tourist.services.*;
import com.db.tourist.utils.FileHelper;
import com.db.tourist.utils.UploadedFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;

@Service
public class ObjectServiceImpl implements ObjectService {
    @Autowired
    private ObjectRepository objectRepository;

    @Autowired
    private PhotoRepository photoRepository;

    @Autowired
    private FileHelper fileHelper;

    @Autowired
    private EpochService epochService;

    @Autowired
    private TypeService typeService;

    @Autowired
    private StyleService styleService;

    @Autowired
    private UserService userService;

    @Autowired
    private CommentService commentService;

    public List<Object> findAll() {
        List<Object> objects = objectRepository.findAll();
        for (Object o: objects) o.setRating(getRating(o.getId()));
        return objects;
    }

    public void delete(Long id) {
        objectRepository.delete(id);
    }

    public Float getRating(Long id) {
        List<Comment> comments = commentService.getComments(id);
        BigDecimal result = BigDecimal.ZERO;
        if(comments.size() > 0) {
            for (Comment c : comments) {
                result = result.add(BigDecimal.valueOf(c.getMark()));
            }
            result = result.divide(BigDecimal.valueOf(comments.size()));
        }
        result = result.setScale(1, RoundingMode.HALF_UP);
        Float r = result.floatValue();

        if(r <= 0.2F) r = 0F;
        else if(r > 0.2F && r <= 0.7F) r = 0.5F;
        else if(r > 0.7F && r <= 1.2F) r = 1.0F;
        else if(r > 1.2F && r <= 1.7F) r = 1.5F;
        else if(r > 1.7F && r <= 2.2F) r = 2.0F;
        else if(r > 2.2F && r <= 2.7F) r = 2.5F;
        else if(r > 2.7F && r <= 3.2F) r = 3.0F;
        else if(r > 3.2F && r <= 3.7F) r = 3.5F;
        else if(r > 3.7F && r <= 4.2F) r = 4.0F;
        else if(r > 4.2F && r <= 4.7F) r = 4.5F;
        else if(r > 4.7F) r = 5F;
        return r;
    }

    public Collection<Object> findRelevant(Integer count) {
        if(!userService.isAuthentificated())
            return null;

        User u = userService.findOne(userService.getUser().getId());
        //по типу
        Set<Object> objects = new LinkedHashSet<>();
        for (Type t : u.getTypeList()) objects.addAll(t.getObjectList());
        //по стилю
        for (Style s : u.getStyleList()) objects.addAll(s.getObjectList());
        //по эпохе
        for (Epoch e : u.getEpochList()) objects.addAll(e.getObjectList());

        Set<Object> relevantsBy3 = new LinkedHashSet<>();
        Set<Object> relevantsBy2 = new LinkedHashSet<>();
        for(Object o: objects) {
            boolean isEpoch = false, isType = false, isStyle = false;
            for (Epoch e : o.getEpochList()) { if (u.getEpochList().contains(e)) isEpoch = true; break; }
            for (Type t : o.getTypeList()) { if (u.getTypeList().contains(t)) isType = true; break; }
            for (Style s : o.getStyleList()) { if (u.getStyleList().contains(s)) isStyle = true; break; }
            if(isEpoch && isType && isStyle) relevantsBy3.add(o);
            if(isEpoch && isType || isEpoch && isStyle || isType && isStyle) relevantsBy2.add(o);
        }

        Set<Object> result = new LinkedHashSet<>();
        result.addAll(relevantsBy3);
        result.addAll(relevantsBy2);
        result.addAll(objects);
        result = (Set<Object>)setRatings(result);
        if(count != null) {
            return (new LinkedList<>(result)).subList(0, Math.min(count, objects.size()));
        } else {
            return result;
        }
    }

    public Object save(Object object, List<Long> epochs, List<Long> types, List<Long> styles, List<Integer> years) {
        Set<Epoch> epochList = new HashSet<>();
        Set<Type> typeList = new HashSet<>();
        Set<Style> styleList = new HashSet<>();
        Set<ObjectYear> yearList = new HashSet<>();
        if(epochs != null) epochs.forEach(id -> epochList.add(epochService.findOne(id)));
        if(types != null) types.forEach(id -> typeList.add(typeService.findOne(id)));
        if(styles != null) styles.forEach(id -> styleList.add(styleService.findOne(id)));
        if(object.getParent() != null && object.getParent().getId() == null) object.setParent(null);
        if(object.getId() == null) object.setAuthor(userService.getUser());
        Object o = objectRepository.save(object);
        o.setEpochList(epochList);
        o.setTypeList(typeList);
        o.setStyleList(styleList);
        if(years != null) years.forEach(year -> yearList.add(new ObjectYear(o, year)));
        o.setYearList(yearList);
        return objectRepository.save(o);
    }

    public Object save(Object object) {
        return objectRepository.save(object);
    }

    public Object findOne(Long id) {
        Object object = objectRepository.findOne(id);
        object.setRating(getRating(id));
        return object;
    }

    public Boolean uploadPhoto(UploadedFile file, Long id) {
        MultipartFile multipartFile = file.getMultipartFile();
        String uploadedFile = fileHelper.upload(multipartFile);
        Photo photo = new Photo();
        photo.setObject(objectRepository.findOne(id));
        photo.setFile(uploadedFile);
        return photoRepository.save(photo) != null;
    }

    public List<Object> findByLocalityId(Long id) {
        return objectRepository.findByLocalityId(id);
    }

    public List<Object> findAllByOrderByNameAsc() {
        return objectRepository.findAllByOrderByNameAsc();
    }

    public List<Object> findByLocalityIdOrderByNameAsc(Long id) {
        return objectRepository.findByLocalityIdOrderByNameAsc(id);
    }

    public Collection<Object> setRatings(Collection<Object> objects) {
        for (Object o: objects) o.setRating(getRating(o.getId()));
        return objects;
    }
}
