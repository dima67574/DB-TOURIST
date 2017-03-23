package com.db.tourist.controllers;

import com.db.tourist.models.District;
import com.db.tourist.models.Locality;
import com.db.tourist.models.Region;
import com.db.tourist.services.DistrictService;
import com.db.tourist.services.LocalityService;
import com.db.tourist.services.ObjectService;
import com.db.tourist.services.RegionService;
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
public class LocalityController {

    @Autowired
    private LocalityService localityService;

    @Autowired
    private RegionService regionService;

    @Autowired
    private DistrictService districtService;

    @Autowired
    private ObjectService objectService;

    @ModelAttribute("regionList")
    public List<Region> populateRegions()
    {
        return regionService.findAll();
    }

    @RequestMapping(value = "/localities/{regionId}", method = RequestMethod.GET)
    public ModelAndView localities(@PathVariable("regionId") Long regionId) {
        View view = new View("locality/localities");
        District d = districtService.findOne(regionId);
        view.addObject("title", "Населенные пункты района «" + d.getName() + "»");
        view.addObject("localities", localityService.findByDistrictId(d.getId()));
        return view;
    }

    @RequestMapping(value = "/locality/{id}", method = RequestMethod.GET)
    public ModelAndView locality(@PathVariable("id") Long id) {
        View view = new View("locality/locality");
        Locality l = localityService.findOne(id);
        view.addObject("title", "Достопримечательности нас. пункта «" + l.getName() + "»");
        view.addObject("objects", objectService.setRatings(objectService.findByLocalityIdOrderByNameAsc(id)));
        return view;
    }

    @RequestMapping(value = "/localities", method = RequestMethod.GET)
    public ModelAndView localities() {
        View view = new View("locality/localities");
        view.addObject("title", "Населенные пункты");
        view.addObject("localities", localityService.findAllByOrderByNameAsc());
        return view;
    }

    @RequestMapping(value = "/admin/locality", method = RequestMethod.GET)
    public ModelAndView list() {
        View view = new View("locality/list", true);
        view.addObject("title", "Населенные пункты");
        view.addObject("localities", localityService.findAll());
        return view;
    }

    @ResponseBody
    @RequestMapping(value = "/admin/locality/delete", method = RequestMethod.POST)
    public void delete(@RequestParam("id") Long id) {
        localityService.delete(id);
    }

    @RequestMapping(value = "/admin/locality/add", method = RequestMethod.GET)
    public ModelAndView add() {
        View view = new View("locality/edit", true);
        view.addObject("title", "Создание населенного пункта");
        view.addObject("locality", new Locality());
        return view;
    }

    @RequestMapping(value = "/admin/locality/add", method = RequestMethod.POST)
    public String add(@ModelAttribute("locality") Locality locality, RedirectAttributes redirectAttributes) {
        Locality l = localityService.save(locality);
        if(l != null) {
            redirectAttributes.addFlashAttribute("success", "Населенный пункт успешно создан");
        }
        return "redirect:/admin/locality";
    }

    @RequestMapping(value = "/admin/locality/edit/{id}", method = RequestMethod.GET)
    public ModelAndView edit(@PathVariable("id") Long id) {
        View view = new View("locality/edit", true);
        Locality l = localityService.findOne(id);
        view.addObject("title", "Редактирование населенного пункта");
        view.addObject("locality", l);
        view.addObject("districtList", districtService.findByRegionId(l.getDistrict().getRegion().getId()));
        return view;
    }

    @RequestMapping(value = "/admin/locality/edit/{id}", method = RequestMethod.POST)
    public String edit(Locality locality, RedirectAttributes redirectAttributes) {
        if(localityService.save(locality) != null) {
            redirectAttributes.addFlashAttribute("success", "Населенный пункт успешно отредактирован");
        }
        return "redirect:/admin/locality";
    }

    @ResponseBody
    @RequestMapping(value = "/admin/locality/getLocalities", produces = {"application/json; charset=UTF-8"}, method = RequestMethod.GET)
    public String getCustomers(@RequestParam("districtId") Long districtId) throws JSONException {
        List<Locality> localities = localityService.findByDistrictId(districtId);
        JSONArray array = new JSONArray();
        for(Locality u: localities) {
            JSONObject item = new JSONObject();
            item.put("name", u.getName());
            item.put("id", u.getId());
            array.put(item);
        }
        return array.toString();
    }
}
