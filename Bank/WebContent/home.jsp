<%@page import="java.sql.*"%>
<% 
ResultSet resultSet1=null;
ResultSet resultSet2=null;

try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn1=DriverManager.getConnection("jdbc:mysql://localhost:3306/data","root","");
	Connection conn2=DriverManager.getConnection("jdbc:mysql://localhost:3306/data","root","");
	Statement st1=conn1.createStatement();
	Statement st2=conn2.createStatement();
	String table_name=request.getParameter("table_name");
	String sql1="SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'data' AND table_name = '"+table_name+"' ";
	String sql2="Select * from `"+table_name+"` order by Transaction_number desc LIMIT 5";
	resultSet1=st1.executeQuery(sql1);
		while(resultSet1.next())
		{
			if((resultSet1.getInt("COUNT(*)")==1))
			{
				%><center>
				<table>
				<th>
				<td>TRN_id</td>
				<td>Type</td>
				<td>AMT</td>
				<td>BAL</td>
				</th></table>
				</center>
				<%
				resultSet2=st2.executeQuery(sql2);
				while(resultSet2.next())
				{%>
					<center>
					<table>
					<tr>
					<td><%= resultSet2.getString("Transaction_number") %></td>
					<td><%= resultSet2.getString("Type") %></td>
					<td><%= resultSet2.getString("Amount") %></td>
					<td><%= resultSet2.getString("Balance") %></td>
					</tr>
					</table>
					</center>
				<%
				}
				%>
				<center>
				<a href="home.html">Go Back</a>
				</center>
				<%
			}
			else
			{
			response.sendRedirect("Noacc.html");
			}
        }
}
catch(Exception e)
{
	out.println(e);
}
%>