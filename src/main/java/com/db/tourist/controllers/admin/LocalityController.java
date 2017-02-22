package com.db.tourist.controllers.admin;

import com.db.tourist.models.District;
import com.db.tourist.models.Locality;
import com.db.tourist.models.Region;
import com.db.tourist.services.DistrictService;
import com.db.tourist.services.LocalityService;
import com.db.tourist.services.RegionService;
import com.db.tourist.utils.View;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Controller
public class LocalityController {

    @Autowired
    private LocalityService localityService;

    @Autowired
    private RegionService regionService;

    @Autowired
    private DistrictService districtService;

    @ModelAttribute("districtList")
    public Map populateDistricts()
    {
        List<District> districtList = districtService.findAll();
        Map<String, String> map = new LinkedHashMap<String, String>();
        for(District r : districtList) {
            map.put(Objects.toString(r.getId()), r.getName());
        }
        return map;
    }

    @ModelAttribute("regionList")
    public Map populateRegions()
    {
        List<Region> regionList = regionService.findAll();
        Map<String, String> map = new LinkedHashMap<String, String>();
        for(Region r : regionList) {
            map.put(Objects.toString(r.getId()), r.getName());
        }
        return map;
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
        view.addObject("title", "Редактирование населенного пункта");
        view.addObject("locality", localityService.findOne(id));
        return view;
    }

    @RequestMapping(value = "/admin/locality/edit/{id}", method = RequestMethod.POST)
    public String edit(Locality locality, RedirectAttributes redirectAttributes) {
        if(localityService.save(locality) != null) {
            redirectAttributes.addFlashAttribute("success", "Населенный пункт успешно отредактирован");
        }
        return "redirect:/admin/locality";
    }
}
