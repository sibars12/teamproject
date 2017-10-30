package filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(filterName = "auth")
public class Masterfilter extends HttpFilter {

	@Override
	protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpSession session =  request.getSession();
		if(session.getAttribute("auth")!=null && session.getAttribute("auth").equals("MASTER")) {
			chain.doFilter(request, response);
		}else {
			String uri=request.getRequestURI();
			System.out.println(uri);
			String query = request.getQueryString();
			System.out.println(query);
			request.getSession().setAttribute("move", uri);
			// response.sendRedirect("/log/login.jsp");
			request.getRequestDispatcher("/").forward(request, response);
		}
	}
}




