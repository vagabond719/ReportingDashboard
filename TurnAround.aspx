<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TurnAround.aspx.cs" Inherits="MetricsDashboard.TurnAround" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="StyleSheet1.css"/>
    <style type="text/css">
    body {
        background-color: #808080;
    }
        .auto-style1 {
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="mGrid" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="2" CellSpacing="2" ForeColor="Black">
            <AlternatingRowStyle BackColor="#EEEEEE" />
            <Columns>
                <asp:BoundField DataField="Assigned" HeaderText="Assigned" SortExpression="Assigned" />
                <asp:BoundField DataField="INC_AVG" HeaderText="INC_AVG" SortExpression="INC_AVG" />
                <asp:BoundField DataField="SR_AVG" HeaderText="SR_AVG" SortExpression="SR_AVG" />
                <asp:BoundField DataField="CHG_AVG" HeaderText="CHG_AVG" SortExpression="CHG_AVG" />
                <asp:BoundField DataField="TASK_AVG" HeaderText="TASK_AVG" SortExpression="TASK_AVG" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                        <RowStyle BackColor="White" />
                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#808080" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="select a.*, TIME_FORMAT(SEC_TO_TIME(b.avg),'%Hh %im %ss') as INC_AVG, TIME_FORMAT(SEC_TO_TIME(c.avg),'%Hh %im %ss') as SR_AVG,
TIME_FORMAT(SEC_TO_TIME(d.avg),'%Hh %im %ss') as CHG_AVG, TIME_FORMAT(SEC_TO_TIME(e.avg),'%Hh %im %ss') as TASK_AVG from 
(select distinct(`assigned_to`) as Assigned from `dsbpws01`.`servicenow_sla2` where
(`resolved_at`  &gt;= CURDATE() - INTERVAL 30 DAY)
 and `assignment_group` like  '%tac%'
and `assignment_group` &lt;&gt;  'tac network l1'
and `assignment_group` &lt;&gt; 'tac alert management'
and `assigned_to` &lt;&gt; '') as a
left join 
(SELECT
	avg(TIMESTAMPDIFF(SECOND,`opened_at`, `resolved_at`)) as avg, `assigned_to` as Assigned
    FROM `dsbpws01`.`servicenow_sla2` 
    where `resolved_at`  &gt;= CURDATE() - INTERVAL 30 DAY and `type` = 'inc'
 and `assignment_group` like  '%tac%'
and `assignment_group` &lt;&gt;  'tac network l1'
and `assignment_group` &lt;&gt; 'tac alert management'
and `close_code` not like '%cancelled%' and `assigned_to` &lt;&gt; ''
group by `assigned_to`) as b on a.Assigned=b.Assigned
left join
(SELECT
    avg(TIMESTAMPDIFF(SECOND,`opened_at`, `resolved_at`)) as avg, `assigned_to` as Assigned
    FROM `dsbpws01`.`servicenow_sla2` 
    where `resolved_at` like  '2015-09%'
 and `assignment_group` like  '%tac%'
and `assignment_group` &lt;&gt;  'tac network l1'
and `assignment_group` &lt;&gt; 'tac alert management'
and `type` like 'rit' 
and `assigned_to` &lt;&gt; ''group by `assigned_to`) as c on a.Assigned=c.Assigned
left join
(SELECT
    avg(TIMESTAMPDIFF(SECOND,`opened_at`, `resolved_at`)) as avg, `assigned_to` as Assigned
    FROM `dsbpws01`.`servicenow_sla2` 
    where `resolved_at` like  '2015-09%'
 and `assignment_group` like  '%tac%'
and `assignment_group` &lt;&gt;  'tac network l1'
and `assignment_group` &lt;&gt; 'tac alert management'
and `number` like 'chg%' group by `assigned_to`
) as d on a.Assigned=d.Assigned
left join
(SELECT
    avg(TIMESTAMPDIFF(SECOND,`opened_at`, `resolved_at`)) as avg, `assigned_to` as Assigned
    FROM `dsbpws01`.`servicenow_sla2` 
    where `resolved_at` like  '2015-09%'
 and `assignment_group` like  '%tac%'
and `assignment_group` &lt;&gt;  'tac network l1'
and `assignment_group` &lt;&gt; 'tac alert management'
and `number` like 'ctask%' and `assigned_to` &lt;&gt; ''
group by `assigned_to`) as e on a.Assigned=e.Assigned
"></asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
