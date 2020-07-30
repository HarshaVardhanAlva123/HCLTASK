<%@page import="java.sql.*"%>
<%
ResultSet resultSet1=null;
ResultSet resultSet2=null;
try
{
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn1=DriverManager.getConnection("jdbc:mysql://localhost:3306/data","root","");
	Connection conn2=DriverManager.getConnection("jdbc:mysql://localhost:3306/data","root","");
	Connection conn3=DriverManager.getConnection("jdbc:mysql://localhost:3306/data","root","");
	Statement st1=conn1.createStatement();
	Statement st2=conn1.createStatement();
	Statement st3=conn1.createStatement();
	String table_name=request.getParameter("table_name");
	String sql1="SELECT Transaction_number,Balance FROM `"+table_name+"` order by Transaction_number desc LIMIT 1";
	resultSet1=st1.executeQuery(sql1);
	while(resultSet1.next())
	{
		int c=resultSet1.getInt("Transaction_number")+1;
		int b=resultSet1.getInt("Balance")-1000;
		if(b>0)
		{	
		String sql2="insert into `"+table_name+"` (Transaction_number,Type,Amount,Balance) values("+c+",'Debit',1000,"+b+")";
		st2.executeUpdate(sql2);
		%>
		<center>
		<%= "Money Debited Rs 1000/-" %>
		<br><br><br>
		</center>
		<%
		}
		else
		{
			response.sendRedirect("NoBal.html");
		}		
	}
	String sql3="Select * from `"+table_name+"` order by Transaction_number desc LIMIT 5";
	resultSet2=st2.executeQuery(sql3);
	%><center>
	<tr>
	<td>TRN_id</td>
	<td>Type</td>
	<td>AMT</td>
	<td>BAL</td>
	</tr>
	</center>
	<br>
	<%
	while(resultSet2.next())
	{%>
	<center>
	<tr>
	<td><%= resultSet2.getString("Transaction_number") %></td>
	<td><%= resultSet2.getString("Type") %></td>
	<td><%= resultSet2.getString("Amount") %></td>
	<td><%= resultSet2.getString("Balance") %></td>
	</tr>
	</center>
	<br>
<%
	}
	%>
	<center>
	<a href="home.html">Go Back</a>
	</center>
	<%
}
catch(Exception e)
{
	response.sendRedirect("Noacc.html");
}
%>