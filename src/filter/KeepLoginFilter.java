package filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(filterName="keep")
public class KeepLoginFilter extends HttpFilter {
	@Override
	protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		Cookie[] ar = request.getCookies();
		HttpSession session = request.getSession();
		
		if(ar != null && session.isNew()) {
			for(Cookie t : ar) {
				if(t.getName().equals("keep")) {
					session.setAttribute("auth", t.getValue());
					break;
				}
			}
		}
		
		chain.doFilter(request, response);
		
	}
}














