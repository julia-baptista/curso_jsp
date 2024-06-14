package servlets;

import java.util.HashMap;
import java.util.List;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;

import org.apache.commons.io.IOUtils;
import org.apache.tomcat.util.codec.binary.Base64;

import com.fasterxml.jackson.databind.ObjectMapper;

import beandto.BeanDtoGraficoSalarioUser;
import dao.DAOUsuarioRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
// import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.ModelLogin;
import util.ReportUtil;


//@WebServlet(urlPatterns = {"/principal/usuario.jsp"})
@MultipartConfig
public class ServletUsuarioController extends ServletGenericUtil {
	private static final long serialVersionUID = 1L;
	
	private DAOUsuarioRepository daoUsuarioRepository = new DAOUsuarioRepository();
       
    
    public ServletUsuarioController() {
 
    }

	@SuppressWarnings("unused")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			String acao = request.getParameter("acao");
			
			if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletar")) {
				
				String idUser = request.getParameter("id");
				
				daoUsuarioRepository.deletarUser(idUser);
				
				List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
				request.setAttribute("modelLogins", modelLogins);
				
				request.setAttribute("msg", "Usuário excluído com sucesso!");
				
				Integer paginas = daoUsuarioRepository.totalPagina(super.getUserLogado(request));
				
				request.setAttribute("totalPagina", paginas);
				
				RequestDispatcher redireciona = request.getRequestDispatcher("principal/usuario.jsp");
				
				redireciona.forward(request, response);
				
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletarajax")) {
				
				String idUser = request.getParameter("id");
				
				daoUsuarioRepository.deletarUser(idUser);
				
				response.getWriter().write("Usuário excluído com sucesso!");
				
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscarUserAjax")) {
				
				String nomeBusca = request.getParameter("nomeBusca");
				
				List<ModelLogin> dadosJsonUser = daoUsuarioRepository.consultaUsuarioList(nomeBusca, super.getUserLogado(request));
				
				//jakson list to json
				ObjectMapper mapper = new ObjectMapper();
				String json = mapper.writeValueAsString(dadosJsonUser);
				
				response.addHeader("totalPagina", "" + daoUsuarioRepository.consultaUsuarioListTotalPaginaPaginacao(nomeBusca, super.getUserLogado(request)));
				response.getWriter().write(json);

				
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscarUserAjaxPage")) {
				
				String nomeBusca = request.getParameter("nomeBusca");
				String pagina = request.getParameter("pagina");
				
				List<ModelLogin> dadosJsonUser = daoUsuarioRepository.consultaUsuarioListOffSet(nomeBusca, super.getUserLogado(request), Integer.parseInt(pagina));
				
				//jakson list to json
				ObjectMapper mapper = new ObjectMapper();
				String json = mapper.writeValueAsString(dadosJsonUser);
				
				response.addHeader("totalPagina", "" + daoUsuarioRepository.consultaUsuarioListTotalPaginaPaginacao(nomeBusca, super.getUserLogado(request)));
				response.getWriter().write(json);

				
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("buscarEdiar")) {
				
				String id = request.getParameter("id");
				
				ModelLogin modelLogin = daoUsuarioRepository.consultaUsuarioID(id, super.getUserLogado(request));
				
				List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
				request.setAttribute("modelLogins", modelLogins);
				
				request.setAttribute("msg", "Usuário em edição"); 
				request.setAttribute("modelLogin", modelLogin);
				
				Integer paginas = daoUsuarioRepository.totalPagina(super.getUserLogado(request));				
				request.setAttribute("totalPagina", paginas);
				
				RequestDispatcher redireciona = request.getRequestDispatcher("principal/usuario.jsp");		
				redireciona.forward(request, response);

				
			}  else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("listarUser")) {
				
				List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
				
				request.setAttribute("msg", "Usuários carregados"); 
				request.setAttribute("modelLogins", modelLogins);
				//request.getSession().setAttribute("msg", "Usuários carregados");
		        //request.getSession().setAttribute("modelLogins", modelLogins);
				
				
				Integer paginas = daoUsuarioRepository.totalPagina(super.getUserLogado(request));				
				
				request.setAttribute("totalPagina", (paginas != null) ? paginas : 0);
				//request.getSession().setAttribute("totalPagina", (paginas != null) ? paginas : 0);
				
				
				RequestDispatcher redireciona = request.getRequestDispatcher("principal/usuario.jsp");		
				redireciona.forward(request, response);
				
				//String contextPath = request.getContextPath();
                //response.sendRedirect(contextPath + "/principal/usuario.jsp");

				
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("downloadFoto")) {
				String idUser = request.getParameter("id");
				
				ModelLogin modelLogin = daoUsuarioRepository.consultaUsuarioID(idUser, super.getUserLogado(request));
				
				if(modelLogin.getFotouser() != null && !modelLogin.getFotouser().isEmpty()) {	
					
					response.setHeader("Content-Disposition", "attachment;filename=arquivo." + modelLogin.getExtensaofotouser());
					
					String base64Image = modelLogin.getFotouser().split(",")[1]; 
					byte[] imageBytes = Base64.decodeBase64(base64Image);
					
					response.getOutputStream().write(imageBytes);
			
				}
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("paginar")) {
				
				Integer offset = Integer.parseInt(request.getParameter("pagina"));
				
				List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioListPaginada(super.getUserLogado(request), offset);
				request.setAttribute("modelLogins", modelLogins);
				
				Integer paginas = daoUsuarioRepository.totalPagina(super.getUserLogado(request));				
				request.setAttribute("totalPagina", paginas);
				
				RequestDispatcher redireciona = request.getRequestDispatcher("principal/usuario.jsp");		
				redireciona.forward(request, response);
				
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("deletarModelLoginAjax")) {
					
				request.setAttribute("modelLogin", null);
				
				System.out.println("modelLogin: " + request.getAttribute("modelLogin"));

			    // Prepare JSON response
			    response.setContentType("application/json");
			    response.setCharacterEncoding("UTF-8");

			    PrintWriter out = response.getWriter();
			    out.print("{\"success\": true}");
			    out.flush();
				
			
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("imprimirRelatorioUser")) {	
				
				String dataInicial = request.getParameter("dataInicial");
				String dataFinal = request.getParameter("dataFinal");
				
				if (dataInicial == null || dataInicial.isEmpty()
						&& dataFinal == null || dataFinal.isEmpty()) {
					
					request.setAttribute("listaUser", daoUsuarioRepository.consultaUsuarioListRel(super.getUserLogado(request)));
					
				} else {
					request.setAttribute("listaUser", daoUsuarioRepository
							.consultaUsuarioListRel(super.getUserLogado(request), dataInicial, dataFinal));
				}

				
				request.setAttribute("dataInicial", dataInicial);
				request.setAttribute("dataFinal", dataFinal);
				request.getRequestDispatcher("principal/reluser.jsp").forward(request, response);
		
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("imprimirRelatorioPDF")
					|| acao.equalsIgnoreCase("imprimirRelatorioExcel")) {
				
				String dataInicial = request.getParameter("dataInicial");
				String dataFinal = request.getParameter("dataFinal");
				
				List<ModelLogin> modelLogins = null;
				
				if (dataInicial == null || dataInicial.isEmpty()
						&& dataFinal == null || dataFinal.isEmpty()) {
					
					modelLogins = daoUsuarioRepository.consultaUsuarioListRel(super.getUserLogado(request));
					
				} else {
					modelLogins = daoUsuarioRepository.consultaUsuarioListRel(super.getUserLogado(request), dataInicial, dataFinal);
						
					
				}
				
				HashMap<String, Object> params = new HashMap<String, Object>();
				params.put("PARAM_SUB_REPORT", request.getServletContext().getRealPath("relatorio") + File.separator);
				
				
				byte[] relatorio = null;
				String extensao = "";

				if(acao.equalsIgnoreCase("imprimirRelatorioPDF")) {
					
					relatorio = new ReportUtil().geraRelatorioPDF(modelLogins, "rel-user-jsp", params, request.getServletContext());
					extensao = "pdf";
				} else if (acao.equalsIgnoreCase("imprimirRelatorioExcel")) {
					relatorio = new ReportUtil().geraRelatorioExcel(modelLogins, "rel-user-jsp", params, request.getServletContext());
					extensao = "xls";
				}
				
				
				response.setHeader("Content-Disposition", "attachment;filename=arquivo." + extensao);								
				response.getOutputStream().write(relatorio);
				
				
			} else if (acao != null && !acao.isEmpty() && acao.equalsIgnoreCase("graficoSalario")) {
				
				String dataInicial = request.getParameter("dataInicial");
				String dataFinal = request.getParameter("dataFinal");
				
				BeanDtoGraficoSalarioUser beanDtoGraficoSalarioUser = new BeanDtoGraficoSalarioUser();
				
				if (dataInicial == null || dataInicial.isEmpty()
						&& dataFinal == null || dataFinal.isEmpty()) {
					
					beanDtoGraficoSalarioUser = daoUsuarioRepository.montarGraficoMediaSalario(super.getUserLogado(request));
					
				} else {
					beanDtoGraficoSalarioUser = daoUsuarioRepository.montarGraficoMediaSalario(super.getUserLogado(request), dataInicial, dataFinal);
						
					
				}
				
				//jakson list to json
				ObjectMapper mapper = new ObjectMapper();
				String json = mapper.writeValueAsString(beanDtoGraficoSalarioUser);			
				response.getWriter().write(json);
				
			} else {
				
				List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
				request.setAttribute("modelLogins", modelLogins);
				
				Integer paginas = daoUsuarioRepository.totalPagina(super.getUserLogado(request));				
				request.setAttribute("totalPagina", paginas);
				
				request.getRequestDispatcher("principal/usuario.jsp").forward(request, response);
			}
			
			
		
		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);
			
//			request.getSession().setAttribute("msg", e.getMessage());
//	        String contextPath = request.getContextPath();
//	        response.sendRedirect(contextPath + "/erro.jsp");
			
		}
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			String msg = "Usuário gravado com sucesso!";
		
			String id = request.getParameter("id");
			String nome = request.getParameter("nome");
			String email = request.getParameter("email");
			String login = request.getParameter("login");
			String senha = request.getParameter("senha");
			String sexo = request.getParameter("sexo");
			String perfil = request.getParameter("perfil");
			String cep = request.getParameter("cep");
			String logradouro = request.getParameter("logradouro");
			String bairro = request.getParameter("bairro");
			String localidade = request.getParameter("localidade");
			String uf = request.getParameter("uf");
			String numero = request.getParameter("numero");
			String dataNascimento = request.getParameter("dataNascimento");
			String rendaMensal = request.getParameter("rendamensal");
			
			if (rendaMensal != null) {
				rendaMensal = rendaMensal.split("\\ ")[1].replaceAll("\\.", "").replaceAll("\\,", ".");
			}
					
			ModelLogin modelLogin = new ModelLogin();
			
			modelLogin.setId(id != null && !id.isEmpty() ? Long.parseLong(id) : null);
			modelLogin.setNome(nome);
			modelLogin.setEmail(email);
			modelLogin.setLogin(login);
			modelLogin.setSenha(senha);
			modelLogin.setSexo(sexo);
			modelLogin.setPerfil(perfil);
			modelLogin.setCep(cep);
			modelLogin.setLogradouro(logradouro);
			modelLogin.setBairro(bairro);
			modelLogin.setLocalidade(localidade);
			modelLogin.setUf(uf);
			modelLogin.setNumero(numero);
			if(dataNascimento != null) {
				modelLogin.setDataNascimento(Date.valueOf(new SimpleDateFormat("yyyy-mm-dd").format(new SimpleDateFormat("dd/mm/yyyy").parse(dataNascimento))));
			}
			if(rendaMensal != null) {
				modelLogin.setRendamensal(Double.valueOf(rendaMensal));
			}
			
			boolean isMultipart = request.getContentType() != null && request.getContentType().startsWith("multipart/form-data");
			
			
			if(isMultipart) {
				
				Part part = request.getPart("fileFoto"); /*Pega foto da tela*/
				
				if(part.getSize() > 0) {				
					byte[] foto = IOUtils.toByteArray(part.getInputStream()); /*Converte imagem para byte*/
					new Base64();
					String imagemBase64 = "data:image/" + part.getContentType().split("\\/")[1] + ";base64," + Base64.encodeBase64String(foto); /*Converte byte para string*/
					
					modelLogin.setFotouser(imagemBase64);
					modelLogin.setExtensaofotouser(part.getContentType().split("\\/")[1]);
				}
				
			}
			
			if(daoUsuarioRepository.validarLogin(modelLogin.getLogin()) && modelLogin.getId() == null) {
				
				msg = "Já existe usuário com o mesmo login, informe outro login";
				
			} else {
				
				if(!modelLogin.isNovo()) {
					msg = "Usuário atualizado com sucesso!";
				} 
				
				modelLogin = daoUsuarioRepository.gravarUsuario(modelLogin, super.getUserLogado(request));	
				
			}
			
			List<ModelLogin> modelLogins = daoUsuarioRepository.consultaUsuarioList(super.getUserLogado(request));
			request.setAttribute("modelLogins", modelLogins);
					
			request.setAttribute("msg", msg); 
			request.setAttribute("modelLogin", modelLogin);
			
			Integer paginas = daoUsuarioRepository.totalPagina(super.getUserLogado(request));				
			request.setAttribute("totalPagina", paginas);
			
			RequestDispatcher redireciona = request.getRequestDispatcher("principal/usuario.jsp");		
			redireciona.forward(request, response);
		
		} catch (Exception e) {
			e.printStackTrace();
			RequestDispatcher redirecionar = request.getRequestDispatcher("erro.jsp");
			request.setAttribute("msg", e.getMessage());
			redirecionar.forward(request, response);
		}
	}
}
