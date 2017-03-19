package com.db.tourist.controllers.admin;

import com.db.tourist.models.Object;
import com.db.tourist.services.*;
import com.db.tourist.utils.UploadedFile;
import com.db.tourist.utils.View;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class ObjectController {

    @Autowired
    private ObjectService objectService;

    @Autowired
    private EpochService epochService;

    @Autowired
    private StyleService styleService;

    @Autowired
    private TypeService typeService;

    @Autowired
    private RegionService regionService;

    @Autowired
    private DistrictService districtService;

    @Autowired
    private LocalityService localityService;

    @Autowired
    private PhotoService photoService;

    @RequestMapping(value = "/object/{id}", method = RequestMethod.GET)
    public ModelAndView object(@PathVariable("id") Long id) {
        View view = new View("object");
        Object object = objectService.findOne(id);
        if(object != null) {
            view.addObject("title", "Достопримечательность «" + object.getName() + "»");
            view.addObject("object", object);
        }
        return view;
    }

    @RequestMapping(value = "/admin/object", method = RequestMethod.GET)
    public ModelAndView list() {
        View view = new View("object/list", true);
        view.addObject("title", "Объекты");
        List<Object> objects = objectService.findAll();
        view.addObject("objects", objects);
        return view;
    }

    @RequestMapping(value = "/admin/object/childs/{id}", method = RequestMethod.GET)
    public ModelAndView list(@PathVariable("id") Long id) {
        View view = new View("object/list", true);
        Object object = objectService.findOne(id);
        view.addObject("title", "Дочерние объекты «" + object.getName() + "»");
        view.addObject("objects", object.getChildObjects());
        view.addObject("childs", true);
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/admin/object/delete", method = RequestMethod.POST)
    public void delete(@RequestParam("id") Long id) {
        objectService.delete(id);
    }

    @RequestMapping(value = "/admin/object/add", method = RequestMethod.GET)
    public ModelAndView add() {
        View view = new View("object/edit", true);
        view.addObject("title", "Создание объекта");
        view.addObject("object", new Object());
        view.addObject("epochs", epochService.findAll());
        view.addObject("styles", styleService.findAll());
        view.addObject("types", typeService.findAll());
        view.addObject("regions", regionService.findAll());
        view.addObject("districts", districtService.findAll());
        view.addObject("localities", localityService.findAll());
        return view;
    }

    @RequestMapping(value = "/admin/object/add", method = RequestMethod.POST)
    public String add(@ModelAttribute("object") Object object,
                      @RequestParam(value = "epochs", required = false) List<Long> epochs,
                      @RequestParam(value = "types", required = false) List<Long> types,
                      @RequestParam(value = "styles", required = false) List<Long> styles,
                      @RequestParam(value = "years", required = false) List<Integer> years,
                      RedirectAttributes redirectAttributes) {
        Object o = objectService.save(object, epochs, types, styles, years);
        if(o != null) {
            redirectAttributes.addFlashAttribute("success", "Объект успешно создан. Теперь вы можете добавить фотографии");
            return "redirect:/admin/object/photo/" + o.getId();
        }
        return "redirect:/admin/object";
    }

    @RequestMapping(value = "/admin/object/edit/{id}", method = RequestMethod.GET)
    public ModelAndView edit(@PathVariable("id") Long id) {
        View view = new View("object/edit", true);
        view.addObject("title", "Редактирование объекта");
        Object o = objectService.findOne(id);
        view.addObject("object", o);
        view.addObject("epochs", epochService.findAll());
        view.addObject("styles", styleService.findAll());
        view.addObject("types", typeService.findAll());
        view.addObject("regions", regionService.findAll());
        if(o.getLocality() != null) {
            view.addObject("districts", districtService.findByRegionId(o.getLocality().getDistrict().getRegion().getId()));
            view.addObject("localities", localityService.findByDistrictId(o.getLocality().getDistrict().getId()));
            view.addObject("parents", objectService.findByLocalityId(o.getLocality().getId()));
        }
        return view;
    }

    @RequestMapping(value = "/admin/object/edit/{id}", method = RequestMethod.POST)
    public String edit(Object object,
                       @RequestParam(value = "epochs", required = false) List<Long> epochs,
                       @RequestParam(value = "types", required = false) List<Long> types,
                       @RequestParam(value = "styles", required = false) List<Long> styles,
                       @RequestParam(value = "years", required = false) List<Integer> years,
                       @PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        Object o = objectService.findOne(id);
        object.setCover(o.getCover());
        object.setAuthor(o.getAuthor());
        if(objectService.save(object, epochs, types, styles, years) != null) {
            redirectAttributes.addFlashAttribute("success", "Объект успешно отредактирован");
        }
        return "redirect:/admin/object";
    }

    @RequestMapping(value = "/admin/object/photo/{id}", method = RequestMethod.GET)
    public ModelAndView photos(@PathVariable("id") Long id) {
        View view = new View("photo", true);
        Object object = objectService.findOne(id);
        if(object != null) {
            view.addObject("title", "Фотоальбом объекта «" + object.getName() + "»");
            view.addObject("object", object);
            view.addObject("objectName", "object");
            view.addObject("backBtnText", "К списку объектов");
            view.addObject("objectTitle", "объект");
        }
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/admin/object/upload", method = RequestMethod.POST)
    public Boolean saveFile(@ModelAttribute UploadedFile uploadedFile, @RequestParam("objectId") Long objectId) {
        return objectService.uploadPhoto(uploadedFile, objectId);
    }

    @RequestMapping(value = "/admin/object/setCover", method = RequestMethod.POST)
    public String setCover(@RequestParam("objectId") Long objectId, @RequestParam("coverId") Long coverId, RedirectAttributes ra) {
        Object object = objectService.findOne(objectId);
        object.setCover(photoService.findOne(coverId));
        objectService.save(object);
        return "redirect:/admin/object/photo/" + object.getId();
    }

    @ResponseBody
    @RequestMapping(value = "/admin/object/getObjects", produces = {"application/json; charset=UTF-8"}, method = RequestMethod.GET)
    public String getCustomers(@RequestParam("localityId") Long localityId) throws JSONException {
        List<Object> objects = objectService.findByLocalityId(localityId);
        JSONArray array = new JSONArray();
        for(Object u: objects) {
            JSONObject item = new JSONObject();
            item.put("name", u.getName());
            item.put("id", u.getId());
            array.put(item);
        }
        return array.toString();
    }
}