package com.scit.project.controller;

import java.util.HashMap;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.scit.project.service.MemberService;
import com.scit.project.util.NaverLoginBO;
import com.scit.project.vo.MemberVO;

@Controller
@RequestMapping(value = "/member")
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private MailSender mailSender;
	
	/* NaverLoginBO */
	@Autowired
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	//로그인 화면으로 이동
	@RequestMapping(value = "/memberLoginPage", method = { RequestMethod.GET, RequestMethod.POST })
	public String memberLoginPage(Model model, HttpSession session) {
		
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		
		//https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		//redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		
		//네이버
		model.addAttribute("url", naverAuthUrl);
		return "member/memberLoginPage";
	}
	
	@RequestMapping(value = "/Login", method = RequestMethod.POST)
	public String memberLogin(MemberVO member, Model model, HttpSession session) {
		String page = service.memberLogin(member);
		return page;
	}
	
	//회원가입 화면으로 이동
	@RequestMapping(value = "/memberJoinForm", method = RequestMethod.GET)
	public String memberJoinForm(Model model, HttpSession session, String kakaoName, String kakaoEmail) {
		HashMap<String, String> hash = new HashMap<String, String>();
		
		String name = "";
		String email = "";
		String str = "";
		
		int cnt = service.emailCheck(kakaoEmail);
		if(cnt!=1) {	
			if (kakaoName == null) {
				// 네이버로 회원가입 시도한 상황
				name = (String) session.getAttribute("sessionName");
				email = (String) session.getAttribute("sessionEmail");
				hash.put("name", name);
				hash.put("email", email);
				model.addAttribute("map", hash);
			} else {
				// 카카오로 회원가입 시도한 상황
				name = kakaoName;
				email = kakaoEmail;
				hash.put("name", name);
				hash.put("email", email);
				model.addAttribute("map", hash);
				return "member/memberJoinForm";
			}
			str = "member/memberJoinForm";
		}else {
			if(kakaoName!=null) {
				session.setAttribute("loginID", kakaoName);
				session.setAttribute("sessionEmail", kakaoEmail);
			}
			str = "redirect:/";
		}
		
		return str;
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String memberJoin(MemberVO member, Model model, RedirectAttributes rttr, HttpServletRequest request, HttpSession session) throws Exception {
		String page = service.memberJoin(member);
		rttr.addFlashAttribute("authmsg" , "가입시 사용한 이메일로 인증해주세요");
		return page;
	}
	
	@ResponseBody			//ajax를 사용하기위해 붙여줘야함 
	@RequestMapping(value = "/idCheck", method = RequestMethod.GET, produces = "application/text;charset=utf-8")
	public String idCheck(String member_id) {
		logger.info(member_id);
		int cnt = service.idCheck(member_id);
		String str = Integer.toString(cnt);
		return str;
	}
	
	@ResponseBody
	@RequestMapping(value = "/emailCheck", method = RequestMethod.GET, produces = "application/text;charset=utf-8")
	public String emailCheck(String member_email) {
		int cnt = service.emailCheck(member_email);
		String str = Integer.toString(cnt);
		return str;
	}
	
	public void setMailSender(MailSender mailSender) {
		this.mailSender = mailSender;
	}
	
	@RequestMapping(value="/emailAuth.do" , produces="text/plain;charset=utf-8")
	@ResponseBody
	public String emailAuth(HttpServletRequest request) {
	    ModelAndView mav = new ModelAndView();
	        
	    String email = request.getParameter("member_email");
	    String authNum = "";
	        
	    System.out.println(email);
	    authNum = randomNum();
	    //가입승인에 사용될 인증키 난수 발생    
	    sendEmail(email, authNum);
	    //이메일전송
	    String str = authNum;
	    
	    return str;
	}
	
	private String randomNum() {
	    StringBuffer buffer = new StringBuffer();
	        
	    for( int i = 0 ; i <= 6 ; i++) {
	        int n = (int)(Math.random()*10);
	        buffer.append(n);
	    }
	        
	    return buffer.toString();
	}
	
	public void sendEmail(String email , String authNum ) {
	    //이메일 발송 메소드
	    SimpleMailMessage mailMessage = new SimpleMailMessage();
	    mailMessage.setSubject("회원가입 안내 .[이메일 제목]");
	    mailMessage.setFrom("rjsdn7732@gmail.com");
	    mailMessage.setText("[이메일 내용]회원가입을 환영합니다. 인증번호를 확인해주세요. [ "+authNum+" ]");
	    mailMessage.setTo(email);
	    try {
	        mailSender.send(mailMessage);
	    } catch (Exception e) {
	        System.out.println(e);
	    }
	}
}
