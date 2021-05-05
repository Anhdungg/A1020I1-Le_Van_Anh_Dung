<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<html>
<head>
    <title>Calculator</title>
    <style>
        .main{
            border: 2px solid #a4a4a4;
            padding: 20px;
            display: flex;
        }
        .input{
            margin: 5px 0 5px 0;
        }
        .label{
            margin: 15px 0 15px 0;
            line-height: 15px;
        }

    </style>
</head>
<body>
<h1>Simple Calculator</h1>
<form action="/calculator" method="post">
    <fieldset class="main">
        <legend>Calculator</legend>
        <div >
            <p class="label" style="margin-top: 5px"><label for="first">First operand:</label></p>
            <p class="label"><label for="operator">Operator:</label></p>
            <p class="label" style="margin-top: 17px"><label for="second">Second operand:</label></p>
        </div>
        <div style="margin-left: 20px">
            <input class="input" type="text" name="first" id="first"><br>
            <select class="input" name="operator" id="operator">
                <option value="+">Addition</option>
                <option value="-">Subtraction</option>
                <option value="*">Multiplication</option>
                <option value="/">Division</option>
            </select><br>
            <input class="input" type="text" name="second" id="second"><br>
            <input class="input" type="submit" value="Calculate" style="border-radius: 10px; background-color: white; border: 1px solid #aaaaaa">
        </div>
    </fieldset>
</form>
</body>
</html>
