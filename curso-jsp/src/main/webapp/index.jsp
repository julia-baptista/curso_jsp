<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<title>Curso JSP</title>
	
	<style type="text/css">
	
	 	body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Full viewport height */
            margin: 0;
            box-sizing: border-box;
        }
        
        .container {
            display: flex;
            flex-direction: column;
            justify-content: top;
            align-items: center;
            margin: 0;
            box-sizing: border-box;
            height: 384px;
        }
        
        h5 {
            margin: 20px 0; /* Space around the heading */
            width: 75%; /* Adjust width if needed */
            text-align: left;
        }
        form {
            margin: 20px 0 20px; /* Space around the form */
            width: 75%; /* Adjust width if needed */
        }
        
        button {
			width: 100%;
		}
		
		.msg-div {
			padding: 0 8px 0 8px;
			margin: 0;
			width: 75%;
		}
		
		.msg {
            margin: 10px 0;
            width: 100%;
            text-align: left;
            font-size: 15px;
            color: #664d03;
            border-color: #ffecb5;
            padding: 10px;
        }
        
        
        @media only screen and (min-width: 768px) {
        
        	h5, form, .msg-div {
        		width: 400px;
        	}

		  }
		

	</style>
</head>
<body>

<div class="container">
	<h5>Bem vindo ao curso JSP</h5>
	
	<form action="<%=request.getContextPath() %>/ServletLogin" method="post" class="row g-3 needs-validation" novalidate>
	<input type="hidden" value="<%= request.getParameter("url") %>" name="url">
	
		<div class="mb-3">
		    <label for="login" class="form-label">Login</label>
		    <input type="text" class="form-control" id="login" name="login" required>
		    <div class="invalid-feedback">
	        	Informe login.
	      	</div>
	  	</div>
	
	  	<div class="mb-3">
		    <label for="senha" class="form-label">Senha</label>
		    <input type="password" class="form-control" id="senha" name="senha" required>
		     <div class="invalid-feedback">
	        	Informe senha.
	     	</div>
	  	</div>
	
	  	
	  	<div class="col-md-12">
	    	<button type="submit" class="btn btn-primary">Enviar</button>
	  	</div>
	
	</form>
	
	<div class="msg-div">
		<h5 class="msg" style="<%= (request.getAttribute("msg") == null || request.getAttribute("msg").toString().isEmpty()) ? "background-color: transparent;" : "background-color: #fff3cd; border-color: #ffecb5;" %>">${msg}</h5>
	</div>
</div>

<!-- Bootstrap Javascript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

<script type="text/javascript">
// Example starter JavaScript for disabling form submissions if there are invalid fields
(() => {
  'use strict'

  // Fetch all the forms we want to apply custom Bootstrap validation styles to
  const forms = document.querySelectorAll('.needs-validation')

  // Loop over them and prevent submission
  Array.from(forms).forEach(form => {
    form.addEventListener('submit', event => {
      if (!form.checkValidity()) {
        event.preventDefault()
        event.stopPropagation()
      }

      form.classList.add('was-validated')
    }, false)
  })
})()

</script>



</body>
</html>