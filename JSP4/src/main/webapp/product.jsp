<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html bg-dark>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: "Arial", sans-serif;
            background-color: #f8f9fa;
        }

        .card {
            max-width: 700px;
            margin-top: 20px; 
            border: 1px solid #000000;
            border-radius: 20px #000000;
        }
        .card:not(:last-child) {
  			margin-bottom: 20px;
			}
        

        .card-header {
            background-color: #f8f9fa;
            font-weight: bold;
            text-align: center;
        }

        .card-body p {
            text-align: center;
            margin: 5px;
        }
        h1,h5,h4{
        text-align: center;
        margin-top: 70px; 
        }
    </style>
</head>

<body>
    <%@ page import="java.sql.Connection" %>
    <%@ page import="java.sql.DriverManager" %>
    <%@ page import="java.sql.PreparedStatement" %>
    <%@ page import="java.sql.SQLException" %>
    <%@ page import="java.sql.ResultSet" %>

    <% String jdbcUrl = "jdbc:mysql://localhost:3306/studentDb?useSSL=false";
       String username = "root";
       String password = "Hogwards4340$";
    %>
    <% PreparedStatement preparedStatement = null;
        Connection conn = null;%>

    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, username, password);
            int productId = Integer.parseInt(request.getParameter("productid"));
            String productName = request.getParameter("productname");
            double price = Double.parseDouble(request.getParameter("price"));
            String insertQuery = "INSERT INTO product (product_id, product_name, price) VALUES (?, ?, ?)";
            preparedStatement = conn.prepareStatement(insertQuery);
            preparedStatement.setInt(1, productId);
            preparedStatement.setString(2, productName);
            preparedStatement.setDouble(3, price);
            int rowsInserted = preparedStatement.executeUpdate();
            if (rowsInserted == 0) {
                out.println("<h2>Fail to insert data into the table!</h2>");
            } else {
                out.println("<h4>Data added successfully to the table!</h4>");
                String query = "select * from product where product_id="+productId;
                ResultSet res = preparedStatement.executeQuery(query);
    %>

    <h5>Inserted data is</h5>
  

    <div class="container d-flex flex-wrap justify-content-center">
        <% while (res.next()) { %>
        <div class="card">
            <div class="card-header">
             <p>Product Details</p>   
            </div>
            <div class="card-body">
            	<p>Product Id: <%= res.getInt(1) %></p>
                <p>Product Name: <%= res.getString(2) %></p>
                <p>Product Price: <%= res.getDouble(3) %></p>
            </div>
        </div>
        <% } %>
    </div>

    <% }
        } catch (ClassNotFoundException e) {
            out.println("<h2>Error: MySQL JDBC Driver not found!</h2>");
            e.printStackTrace();
        } catch (SQLException e) {
            out.println("<h2>Error: Unable to connect to the database or execute query!</h2>");
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            preparedStatement.close();
            conn.close();
        }
    %>
    
    <div style="text-align: center; margin-top: 20px;">
    <a href="index.html" class="btn btn-primary">Back to Home</a>
	</div>
    
</body>

</html>
