package login1;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import lecture1.ParseUtils;

public class UserService {
    private static final String CURRENT_USER = "CURRENT_USER";

    public static boolean login(HttpSession session, String loginId, String password) throws Exception {
        User user = UserDAO.findByLoginId(loginId);
        if (user == null) return false;
        String encryptedPassword = password;
        if (user.getPassword().equals(encryptedPassword)) {
            session.setAttribute(CURRENT_USER,  user);
            return true;
        }
        return false;
    }

    public static void logout(HttpSession session) {
        session.removeAttribute(CURRENT_USER);
    }

    public static User getCurrentUser(HttpSession session) {
        return (User)session.getAttribute(CURRENT_USER);
    }

    public static String getCurrentUserName(HttpSession session) {
        User user = (User)session.getAttribute(CURRENT_USER);
        return user == null ? "손님" : user.getName();
    }

    public static boolean isCurrentUserLoggedIn(HttpSession session) {
        return session.getAttribute(CURRENT_USER) != null;
    }

    public static boolean checkUserType(HttpSession session, String userType) {
        User user = (User)session.getAttribute(CURRENT_USER);
        return user != null && userType.equals(user.getUserType());
    }

    public static String encrypt(String passwd) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] passBytes = passwd.getBytes();
        md.reset();
        byte[] digested = md.digest(passBytes);
        StringBuffer sb = new StringBuffer();
        for(int i=0;i<digested.length;i++)
            sb.append(Integer.toHexString(0xff & digested[i]));
        return sb.toString();
    }

    public static User createUser(HttpServletRequest request) {
        User user = new User();
        user.setId(ParseUtils.parseInt(request.getParameter("id"), 0));
        user.setLoginId(request.getParameter("loginId"));
        user.setName(request.getParameter("name"));
        user.setEmail(request.getParameter("email"));
        user.setDepartmentId(ParseUtils.parseInt(request.getParameter("departmentId"), 0));
        user.setEnabled(request.getParameter("enabled") != null);
        user.setUserType(request.getParameter("userType"));
        return user;
    }

    static boolean isNullOrEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }

    public static String validate(User user) {
        if (isNullOrEmpty(user.getName())) return "이름을 입력하세요";
        if (isNullOrEmpty(user.getLoginId())) return "로그인ID를 입력하세요";
        if (isNullOrEmpty(user.getUserType())) return "사용자 유형을 입력하세요";
        return null;
    }
}

