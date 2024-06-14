<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<%@ page import="model.ModelLogin" %>
    
    
<!DOCTYPE html>
<html lang="en">

<jsp:include page="head.jsp"></jsp:include>

  <body>
  <jsp:include page="theme-loader.jsp"></jsp:include>
  <div id="pcoded" class="pcoded">
      <div class="pcoded-overlay-box"></div>
      <div class="pcoded-container navbar-wrapper">
          <jsp:include page="navbar.jsp"></jsp:include>

          <div class="pcoded-main-container">
              <div class="pcoded-wrapper">
              
                  <jsp:include page="navbarmainmenu.jsp"></jsp:include>
                 
                  
                <div class="pcoded-content">
                      <!-- Page-header start -->
                      
                      <jsp:include page="page-header.jsp"></jsp:include>
                      
                     
                      <!-- Page-header end -->
                        <div class="pcoded-inner-content">
                            <!-- Main-body start -->
                            <div class="main-body">
                                <div class="page-wrapper">
                                    <!-- Page-body start -->
                                    <div class="page-body">
                                    
                                    	<div class="row">
                                            <div class="col-sm-12">
                                                <!-- Basic Form Inputs card start -->
                                                <div class="card">
                                                    <div class="card-block">
                                                     	<h4 class="sub-title">Cad. Usuário</h4>
			                                        	<form class="form-material" enctype="multipart/form-data" action="<%= request.getContextPath() %>/ServletUsuarioController" method="post" id="formUser">
			                                        	
			                                        		<input type="hidden" name="acao" id="acao" value="">
			                                        	
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="text" name="id" id="id" class="form-control" readonly="readonly" value="${modelLogin.id}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">ID:</label>
                                                            </div>
                                                            
                                                            <div class="form-group form-default input-group mb-4">
	                                                            <div class="input-group-prepend">
	                                                           
	                                                            <c:if test="${modelLogin.fotouser != '' && modelLogin.fotouser != null}">
	                                                            	<a href="<%= request.getContextPath() %>/ServletUsuarioController?acao=downloadFoto&id=${modelLogin.id}">
	                                                            		<img class="img-80 img-radius" alt="Imagem User" id="fotoembase64" src="${modelLogin.fotouser}" style="width: 70px; height: 70px; object-fit: cover;"/>
	                                                            	</a>
	                                                            </c:if>
	                                                             <c:if test="${modelLogin.fotouser == '' || modelLogin.fotouser == null}">
																    <img class="img-80 img-radius" alt="Imagem User" id="fotoembase64" src="assets/images/iconuser.png" style="width: 70px; height: 70px; object-fit: cover;"/>
	                                                            </c:if>
																</div>
                                                            	<input type="file" id="fileFoto" name="fileFoto" accept="image/*" onchange="visualizarImg('fotoembase64', 'fileFoto')" class="form-control-file" style="margin-top: 25px; margin-left: 5px">
                                                            </div>
                                                           
                                                            
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="text" name="nome" id="nome" class="form-control" required="required" value="${modelLogin.nome}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Nome:</label>
                                                            </div>
                                                            
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="text" name="dataNascimento" id="dataNascimento" class="form-control" required="required" value="${modelLogin.dataNascimento}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Dat. Nascimento:</label>
                                                            </div>
                                                            
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="text" name="rendamensal" id="rendamensal" class="form-control" required="required" value="${modelLogin.rendamensal}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Renda Mensal:</label>
                                                            </div>
                                                            
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="email" name="email" id="email" class="form-control" required="required" autocomplete="off" value="${modelLogin.email}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">E-mail:</label>
                                                            </div>

															<%
															ModelLogin modelLogin = (ModelLogin) request.getAttribute("modelLogin");
																if (modelLogin == null) {
															        modelLogin = new ModelLogin();
															        modelLogin.setPerfil("");
															        modelLogin.setSexo("MASCULINO");
															    } else if (modelLogin.getPerfil() == null) {
															        modelLogin.setPerfil("");
															    }
															%>
															<div class="form-group form-default form-static-label">
																<select class="form-control"
																	aria-label="Default select example" name="perfil">
																	<option selected disabled="disabled">[Selecione
																		o perfil]</option>
																	<option value="ADMIN"
																		<%if (modelLogin.getPerfil().equals("ADMIN")) {%>
																		selected="selected" <%}%>>Admin</option>
																	<option value="SECRETARIA"
																		<%if (modelLogin.getPerfil().equals("SECRETARIA")) {%>
																		selected="selected" <%}%>>Secretária</option>
																	<option value="AUXILIAR"
																		<%if (modelLogin.getPerfil().equals("AUXILIAR")) {%>
																		selected="selected" <%}%>>Auxiliar</option>
																</select> <span class="form-bar"></span> <label
																	class="float-label">Perfil:</label>
															</div>

															<div class="form-group form-default form-static-label">
                                                                <input onblur="pesquisaCep();" type="text" name="cep" id="cep" class="form-control" required="required" autocomplete="off" value="${modelLogin.cep}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Cep:</label>
                                                            </div>
                                                            
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="text" name="logradouro" id="logradouro" class="form-control" required="required" autocomplete="off" value="${modelLogin.logradouro}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Rua:</label>
                                                            </div>
                                                            
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="text" name="bairro" id="bairro" class="form-control" required="required" autocomplete="off" value="${modelLogin.bairro}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Bairro:</label>
                                                            </div>
                                                                
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="text" name="localidade" id="localidade" class="form-control" required="required" autocomplete="off" value="${modelLogin.localidade}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Cidade:</label>
                                                            </div>
                                                            
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="text" name="uf" id="uf" class="form-control" required="required" autocomplete="off" value="${modelLogin.uf}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Estado:</label>
                                                            </div>
                                                            
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="text" name="numero" id="numero" class="form-control" required="required" autocomplete="off" value="${modelLogin.numero}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Número:</label>
                                                            </div>                            

															<div class="form-group form-default form-static-label">
                                                                <input type="text" name="login" id="login" class="form-control" required="required" autocomplete="off" value="${modelLogin.login}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Login:</label>
                                                            </div>
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="password" name="senha" id="senha" class="form-control" required="required" autocomplete="off"value="${modelLogin.senha}">
                                                                <span class="form-bar"></span>
                                                                <label class="float-label">Senha:</label>
                                                            </div>
                                                            <div class="form-group form-default form-static-label">
                                                                <input type="radio" name="sexo" value="MASCULINO" checked="checked"
                                                                	<%if (modelLogin.getSexo().equals("MASCULINO")) {%>
																		checked="checked" <%}%>>Masculino</>
                                                                 <input type="radio" name="sexo" value="FEMININO"
                                                                 	<%if (modelLogin.getSexo().equals("FEMININO")) {%>
																		checked="checked" <%}%>>Feminino</>
                                                            </div>
                                                            
                                                            
                                                            <button type="button" class="btn btn-primary waves-effect waves-light" onclick="limparForm();">Novo</button>
                                                            <button type="submit" class="btn btn-success waves-effect waves-light">Salvar</button>
												            <button type="button" class="btn btn-info waves-effect waves-light" onclick="criarDelete();">Excluir</button>
												            <c:if test="${modelLogin.id > 0}">
												            	<a id="botaoTelefone" href="<%=request.getContextPath()%>/ServletTelefone?iduser=${modelLogin.id}" class="btn btn-primary waves-effect waves-light">Telefone</a>
												            </c:if>
												            <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#exampleModalUsuario">Pesquisar</button>
                                                        </form>
			                                        </div>
			                                    </div>
			                                 </div>
			                            </div>
			                            <span id="msg">${msg}</span>
			                            
			                            <div style="height: 300px; overflow:scroll;">
											<table class="table" id="tabelaresultadosview">
											  <thead>
											    <tr>
											      <th scope="col">ID</th>
											      <th scope="col">Nome</th>
											      <th scope="col">Ver</th>
											    </tr>
											  </thead>
											  <tbody>
											  	
											  	<c:forEach items="${modelLogins}" var="ml">
											  		<tr>
											  			<td>
											  				<c:out value="${ml.id}"></c:out>
											  			</td>
											  			<td>
											  				<c:out value="${ml.nome}"></c:out>
											  			</td>
											  			<td>
											  				<a class="btn btn-success" href="<%= request.getContextPath() %>/ServletUsuarioController?acao=buscarEdiar&id=${ml.id}">Ver</a>
											  			</td>
											  		</tr>
											  	</c:forEach>
											  
											  </tbody>
											</table>
										</div>

										<nav aria-label="Page navigation example">
											<ul class="pagination">
											
											<%
												int totalPagina = (int) request.getAttribute("totalPagina");
											
												if (totalPagina > 0) {													
													for (int p = 0; p < totalPagina; p++) {
														String url = request.getContextPath() + "/ServletUsuarioController?acao=paginar&pagina=" + (p*5);
														out.print("<li class=\"page-item\"><a class=\"page-link\" href=\"" +url+ "\">"+ (p + 1) +"</a></li>");
													}		
												}
											%>
												
											</ul>
										</nav>

									</div>
                                    <!-- Page-body end -->
                                </div>
                                <div id="styleSelector"> </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
   
    
<jsp:include page="javascriptfile.jsp"></jsp:include>


<!-- Modal -->
<div class="modal fade" id="exampleModalUsuario" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Pesquisa de usuário</h5>
        <button type="button" onclick="limparBuscaModal();" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
        <div class="input-group mb-3">
		  <input type="text" class="form-control" placeholder="Nome" aria-label="nome" id="nomeBusca" aria-describedby="basic-addon2">
		  <div class="input-group-append">
		    <button class="btn btn-success" type="button" onclick="buscarUsuario();">Buscar</button>
		  </div>
		</div>
		
		<div style="height: 300px; overflow:scroll;">
			<table class="table" id="tabelaresultados">
			  <thead>
			    <tr>
			      <th scope="col">ID</th>
			      <th scope="col">Nome</th>
			      <th scope="col">Ver</th>
			    </tr>
			  </thead>
			  <tbody>
			  </tbody>
			</table>
		</div>
		<nav aria-label="Page navigation example">
			<ul class="pagination" id="ulPaginacaoUserAjax"></ul>
		</nav>
					
		<span id="totalResultados">Total resultados:</span>
		
      </div>
      <div class="modal-footer">
        <button type="button" onclick="limparBuscaModal();" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">

	$('#rendamensal').maskMoney({showSymbol:true, symbol:"R$ ", decimal:",", thousands:"."});
	
	const formatter = new Intl.NumberFormat('pt-BR', {
		minimumFractionDigits: 2
	});
	
	$('#rendamensal').val(formatter.format($("#rendamensal").val()));
	
	$('#rendamensal').focus();
	
	var dataNascimento = $("#dataNascimento").val();
	
	if (dataNascimento != null && dataNascimento != '') {
		
		var dateFormat = new Date(dataNascimento);
		
		$('#dataNascimento').val(dateFormat.toLocaleDateString('pt-BR', {timeZone: 'UTC'}));
		
	}
		
	$('nome').focus();
	

	$( function() {
		  
		  $("#dataNascimento").datepicker({
			    dateFormat: 'dd/mm/yy',
			    dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
			    dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
			    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
			    monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
			    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
			    nextText: 'Próximo',
			    prevText: 'Anterior'
			});
	} );


	$('#numero').keypress(function(event) {
	    if (!/\d/.test(event.key)) {
	        event.preventDefault();
	    }
	});
	
	$('#cep').keypress(function(event) {
	    if (!/\d/.test(event.key)) {
	        event.preventDefault();
	    }
	});


	function limpa_formulário_cep() {
	    // Limpa valores do formulário de cep.
	    $("#logradouro").val("");
	    $("#bairro").val("");
	    $("#localidade").val("");
	    $("#uf").val("");
	}

	function pesquisaCep() {
		//Nova variável "cep" somente com dígitos.
		const cep = $('#cep').val().replace(/\D/g, '');

        //Verifica se campo cep possui valor informado.
        if (cep != "") {

            //Expressão regular para validar o CEP.
            var validacep = /^[0-9]{8}$/;

            //Valida o formato do CEP.
            if(validacep.test(cep)) {

                //Preenche os campos com "..." enquanto consulta webservice.
                $("#logradouro").val("...");
                $("#bairro").val("...");
                $("#localidade").val("...");
                $("#uf").val("...");

                //Consulta o webservice viacep.com.br/
                $.getJSON("https://viacep.com.br/ws/"+ cep +"/json/?callback=?", function(dados) {

                    if (!("erro" in dados)) {
                        //Atualiza os campos com os valores da consulta.
                        $("#cep").val(dados.cep);
                        $("#logradouro").val(dados.logradouro);
                        $("#bairro").val(dados.bairro);
                        $("#localidade").val(dados.localidade);
                        $("#uf").val(dados.uf);
                    } //end if.
                    else {
                        //CEP pesquisado não foi encontrado.
                        limpa_formulário_cep();
                        alert("CEP não encontrado.");
                    }
                });
            } //end if.
            else {
                //cep é inválido.
                limpa_formulário_cep();
                alert("Formato de CEP inválido.");
            }
        } //end if.
        else {
            //cep sem valor, limpa formulário.
            limpa_formulário_cep();
        }
		
	}

	function visualizarImg(fotoembase64, fileFoto){
		
		const preview = document.getElementById(fotoembase64); // campo IMG html
		const fileUser = document.getElementById(fileFoto).files[0]; // campo input
		const reader = new FileReader();
		
		reader.onloadend = function () {
			preview.src = reader.result; /*Carrega a foto na tela*/
		}
		
		if (fileUser) {
			reader.readAsDataURL(fileUser); /*Preview da imagem*/
		} else {
			preview.src = "assets/images/iconuser.png";
		}
		
	}

	function verEditar(id) {
		var urlAction = document.getElementById('formUser').action;
		
		// redirecionar com javascripy
		window.location.href = urlAction + '?acao=buscarEdiar&id=' + id;
		
		
		$.ajax({
			
			method: "get",
			url: urlAction,
			data: 'id=' + id + '&acao=buscarEdiar',
			success: function (response) {
				
				limparForm();
				document.getElementById('msg').textContent = response;
			}
			
		}).fail(function(xhr, status, errorThrown){
			alert('Erro ao deletar usuário por id: ' + xhr.responseText);
		});
	}
	

	function buscaUserPagAjax(url) {
		
		var urlAction = document.getElementById('formUser').action;
		var nomeBusca = document.getElementById('nomeBusca').value;
		
		$.ajax({
			
			method: "get",
			url: urlAction,
			data: url,
			success: function (response, textStatus, xhr) {
				
				const json = JSON.parse(response);
				
				$('#tabelaresultados > tbody > tr').remove();
				
				for (var p = 0; p < json.length; p++) {
					$('#tabelaresultados > tbody').append('<tr><td>' + json[p].id +  '</td> <td>' + json[p].nome + '</td> <td><button onclick="verEditar(' +json[p].id+ ');" type="button" class="btn btn-info">Ver</button></td></tr>')
				}
				
				document.getElementById('totalResultados').textContent = 'Resultados: ' + json.length;
				
				const totalPagina = xhr.getResponseHeader("totalPagina");
				
				$('#ulPaginacaoUserAjax > li').remove();
				
				for (var p = 0; p < totalPagina; p++) {
					
					const url = 'nomeBusca=' + nomeBusca + '&acao=buscarUserAjaxPage&pagina=' + (p*5);
					$('#ulPaginacaoUserAjax').append('<li class="page-item"><a class="page-link" href="#" onclick="buscaUserPagAjax(\'' + url + '\')">'+ (p + 1) +'</a></li>');
				}	
				
			}
			
		}).fail(function(xhr, status, errorThrown){
			alert('Erro ao buscar usuário por nome: ' + xhr.responseText);
		});		
	}

	
	

	function buscarUsuario() {
		
		var nomeBusca = document.getElementById('nomeBusca').value;
		
		if (nomeBusca != null && nomeBusca != '' && nomeBusca.trim() != '') {
			
			var urlAction = document.getElementById('formUser').action;	
			
			$.ajax({
				
				method: "get",
				url: urlAction,
				data: 'nomeBusca=' + nomeBusca + '&acao=buscarUserAjax',
				success: function (response, textStatus, xhr) {
					
					const json = JSON.parse(response);
					
					$('#tabelaresultados > tbody > tr').remove();
					
					for (var p = 0; p < json.length; p++) {
						$('#tabelaresultados > tbody').append('<tr><td>' + json[p].id +  '</td> <td>' + json[p].nome + '</td> <td><button onclick="verEditar(' +json[p].id+ ');" type="button" class="btn btn-info">Ver</button></td></tr>')
					}
					
					document.getElementById('totalResultados').textContent = 'Resultados: ' + json.length;
					
					const totalPagina = xhr.getResponseHeader("totalPagina");
					
					$('#ulPaginacaoUserAjax > li').remove();
					
					for (var p = 0; p < totalPagina; p++) {
						const url = 'nomeBusca=' + nomeBusca + '&acao=buscarUserAjaxPage&pagina=' + (p*5);
						$('#ulPaginacaoUserAjax').append('<li class="page-item"><a class="page-link" href="#" onclick="buscaUserPagAjax(\'' + url + '\')">'+ (p + 1) +'</a></li>');
					}
					
					
					
				}
				
			}).fail(function(xhr, status, errorThrown){
				alert('Erro ao buscar usuário por nome: ' + xhr.responseText);
			});
		}
		
	}
	
	
	function limparBuscaModal() {
		
		document.getElementById('nomeBusca').value = '';
		document.getElementById('totalResultados').textContent = 'Total Resultados:';
		
		$('#tabelaresultados > tbody > tr').remove();
		$('#ulPaginacaoUserAjax > li').remove();	
	
	}
	

	function criarDeleteComAjax() {
		
		if(confirm('Deseja realmente exlcuir os dados?')){
			
			var urlAction = document.getElementById('formUser').action;
			var idUser = document.getElementById('id').value;		
			
			$.ajax({
				
				method: "get",
				url: urlAction,
				data: 'id=' + idUser + '&acao=deletarajax',
				success: function (response) {
					
					limparForm();
					document.getElementById('msg').textContent = response;
				}
				
			}).fail(function(xhr, status, errorThrown){
				alert('Erro ao deletar usuário por id: ' + xhr.responseText);
			});
		}
		
	}

	function criarDelete() {
		
		if(confirm('Deseja realmente excluir os dados?')) {
			document.getElementById("formUser").method = 'get';
			document.getElementById("acao").value = 'deletar';
			document.getElementById("formUser").submit();
		}
	}

	function limparForm() {
		const elementos = document.getElementById("formUser").elements; /*Retorna os elementos html dentro do form*/
		
		for (p = 0; p < elementos.length; p++) {
			elementos[p].value = '';
		}
		
		const preview = document.getElementById('fotoembase64');
		preview.src = "assets/images/iconuser.png";
		
		var urlAction = document.getElementById('formUser').action;
		
		$.ajax({
			
			method: "get",
			url: urlAction,
			data: 'acao=deletarModelLoginAjax',
			success: function (response) {
				
				if (response.success) {
	                // Esconder o botão
	                document.getElementById('botaoTelefone').style.display = 'none';
	            }
				
			}
			
		}).fail(function(xhr, status, errorThrown){
			alert('Erro ao deletar usuário por id: ' + xhr.responseText);
		});	
		
	}
	
</script>

</body>

</html>