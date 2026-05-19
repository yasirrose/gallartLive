
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>

<div class="login-container">
	<h2 class="form-title">Login</h2>
	<form action="index.cfm" onSubmit="handleLogin(); return false;" id="loginform" class="login-form">
		<div class="form-group">
			<label for="login-password">Password:</label>
			<input type="password" name="password" id="login-password" placeholder="Enter your Password">
		</div>
		<div class="form-group">
			<input type="submit" name="login" value="Login" class="btn">
		</div>
	</form>
</div>



 <style>
	* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-color: #f4f4f4;
}

.form-title {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 15px;
    color: #333;
}

.login-container {
    background: #f2f2f2;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 300px;
    text-align: center;
	border: 1px solid lightgray;
	margin-top: 10%;
}

.login-form .form-group {
    margin-bottom: 15px;
    text-align: left;
}

.login-form label {
    display: block;
    font-size: 14px;
    margin-bottom: 5px;
    color: #333;
}

.login-form input[type="password"] {
    width: 100%;
    padding: 8px;
	border: 1px solid lightgray !important;
    border-radius: 4px;
}

.btn {
    width: 100%;
    padding: 10px;
    background-color: #EC008C;
    color: #fff;
    
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
}

.btn:hover {
    background-color: #EC008C;
}
 </style>