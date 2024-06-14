package filter;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Scanner;

import connection.SingleConnectionBanco;
import dao.DAOVersionadorBanco;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/*Intercepta todas as requisições que vierem do projeto*/
@WebFilter(urlPatterns = {"/principal/*"})
public class FilterAuthenticacao extends HttpFilter implements Filter {
	
	
	private static final long serialVersionUID = 1L;
	private static Connection connection;
       

    public FilterAuthenticacao() {

    }

    /*Encerra os processos quando o servidor é parado*/
    // ex: mataria os processo de conexão com o banco
	public void destroy() {
		
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/*Intercepta as requisições e da as respostas do sistema*/
	/*Tudo que fizer no sistema vai passar por aqui*/
	// ex: Validação de autenticacao
	// ex: Dar commit e rolback de transações do banco
	// ex: Validar e fazer redirecionamento de páginas
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		try {
			
			HttpServletRequest req = (HttpServletRequest) request;
			HttpSession session = req.getSession();
			
			String usuarioLogado = (String) session.getAttribute("usuario");
			
			String urlParaAutenticar = req.getServletPath(); /*URL que está sendo acessada*/
			
			/*Validar se está logado senão redirecionar para tela de login*/
			if ((usuarioLogado == null || usuarioLogado.equals("null")) && 
					!urlParaAutenticar.equalsIgnoreCase("/principal/ServletLogin")) { /*Não está logado*/
				
				RequestDispatcher redireciona = request.getRequestDispatcher("/index.jsp?url=" + urlParaAutenticar);
				request.setAttribute("msg", "Porfavor realize o login!");
				redireciona.forward(request, response);
				return; /*Para a execussão e redireciona para o login*/
				
			} else {
				chain.doFilter(request, response);
			}
			
			connection.commit(); /*Deu tudo certo, então comita as alterações no banco de dados*/
			
		}catch (Exception e) {
			e.printStackTrace();
			
			RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);			
			
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}				
	}

	/*Inicia os processos ou recursos quando o servidor sobe o projeto*/
	// ex: iniciar conexão com o banco
	public void init(FilterConfig fConfig) throws ServletException {
		
		connection = SingleConnectionBanco.getConnection();
		
		DAOVersionadorBanco daoVersionadorBanco = new DAOVersionadorBanco();
		
		String caminhoPastaSQL = fConfig.getServletContext().getRealPath("versionadorbancosql") + File.separator;
		
		File[] filesSql = new File(caminhoPastaSQL).listFiles();
		
		try {
			
			for (File file : filesSql) {
				
				boolean arquivoJaRodado = daoVersionadorBanco.arquivoSqlRodado(file.getName());
				
				if (!arquivoJaRodado) {
					
					FileInputStream entradaArquivo = new FileInputStream(file);
					
					Scanner lerArquivo = new Scanner(entradaArquivo, "UTF-8");
					
					StringBuilder sql = new StringBuilder();
					
					while(lerArquivo.hasNext()) {
						
						sql.append(lerArquivo.nextLine());
						sql.append("\n");
					}
					
					connection.prepareStatement(sql.toString()).execute();
					
					daoVersionadorBanco.gravaArquivoSqlRodado(file.getName());
					
					connection.commit();
					
					lerArquivo.close();
				}
				
			}
			
		} catch (Exception e) {
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		
		
		
	}

}
