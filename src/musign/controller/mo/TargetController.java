package musign.controller.mo;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import musign.classes.Utils;

@Controller
@RequestMapping("/mo/target/*")
public class TargetController {

   private final Logger log = Logger.getLogger(this.getClass());
   
   @RequestMapping("/list")
   public ModelAndView list(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/mo/target/list");

      return mav;
   }
   
   @RequestMapping("/detail")
   public ModelAndView detail(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/mo/target/detail");

      return mav;
   }

   
   @RequestMapping("/sub_calender")
   public ModelAndView sub_calender(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/mo/target/sub_calender");

      return mav;
   }
   
   @RequestMapping("/sub_memo")
   public ModelAndView sub_memo(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/mo/target/sub_memo");

      return mav;
   }
   
   @RequestMapping("/sub_offer")
   public ModelAndView sub_offer(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/mo/target/sub_offer");

      return mav;
   }
   
   @RequestMapping("/sub_set")
   public ModelAndView sub_set(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/mo/target/sub_set");

      return mav;
   }
   
   @RequestMapping("/sub_work_status")
   public ModelAndView sub_work_status(HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/WEB-INF/pages/mo/target/sub_work_status");

      return mav;
   }
}