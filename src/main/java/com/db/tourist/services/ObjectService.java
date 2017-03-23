package com.db.tourist.services;

import com.db.tourist.models.Object;
import com.db.tourist.utils.UploadedFile;

import java.util.Collection;
import java.util.List;

public interface ObjectService {
    List<Object> findAll();

    Object findOne(Long id);

    void delete(Long id);

    Object save(Object object, List<Long> epochs, List<Long> types, List<Long> styles, List<Integer> years);

    Object save(Object object);

    Boolean uploadPhoto(UploadedFile file, Long id);

    List<Object> findByLocalityId(Long id);

    List<Object> findAllByOrderByNameAsc();

    List<Object> findByLocalityIdOrderByNameAsc(Long id);

    Collection<Object> findRelevant(Integer count);

    Float getRating(Long id);

    Collection<Object> setRatings(Collection<Object> objects);

    List<Object> getTopList();
}
