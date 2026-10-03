<%@ page import="java.sql.*" %>
<html>
<head>
	<title>What Next App</title>
	<style>
		*{
			font-size:40px;
			text-align:center;
		}
		body{
			background-color:lightblue;
		}
		table{
			margin:auto;
			width:80%;
		}
	</style>
</head>
<body>
	<h1>What Next App</h1>

	<form method="POST">
		<label>Name</label>
		<input type="text" name="name" required placeholder="Enter Name" />
		<br/><br/>

		<label>Select One</label>
		<input type="radio" name="choice" value="MS" required />MS
		<input type="radio" name="choice" value="MBA" />MBA
		<br/><br/>

		<input type="submit" name="btn" value="Submit" />
	</form>

<%
	if (request.getParameter("btn") != null)
	{
		String name = request.getParameter("name");
		String choice = request.getParameter("choice");

		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/wnkc13sep26";
			Connection con = DriverManager.getConnection(url, "root", "abc123");

			String sql = "insert into student(name,choice) values(?,?)";
			PreparedStatement pst = con.prepareStatement(sql);
			pst.setString(1, name);
			pst.setString(2, choice);
			pst.executeUpdate();
			out.println("Congrats");

			pst.close();
			con.close();
		}
		catch (SQLException e)
		{
			out.println("sql issue " + e);
		}
		catch (Exception e)
		{
			out.println("issue " + e);
		}
	}
%>

	<br/>
	<table border="5">
		<thead>
			<tr>
				<th>Name</th>
				<th>Choice</th>
			</tr>
		</thead>
		<tbody>
<%
	try
	{
		Class.forName("com.mysql.cj.jdbc.Driver");
		String url2 = "jdbc:mysql://localhost:3306/wnkc13sep26";
		Connection con2 = DriverManager.getConnection(url2, "root", "abc123");

		String sql2 = "select id,name,choice from student";
		PreparedStatement pst2 = con2.prepareStatement(sql2);
		ResultSet rs = pst2.executeQuery();
		while (rs.next())
		{
			int id = rs.getInt(1);
			String sname = rs.getString(2);
			String schoice = rs.getString(3);
%>
			<tr>
				<td><%= sname %></td>
				<td><%= schoice %></td>
			</tr>
<%
		}
		rs.close();
		pst2.close();
		con2.close();
	}
	catch (SQLException e)
	{
		out.println("sql issue " + e);
	}
	catch (Exception e)
	{
		out.println("issue " + e);
	}
%>
		</tbody>
	</table>
</body>
</html>