<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Performance.aspx.cs" Inherits="MetricsDashboard.WebFormPerformance" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="~/StyleSheet2.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div style="display: inline-block;">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Pics/Technology_logo_horz_bw.png" />    
        </div>
        <div style="width: 960px; background-color: #000; height: 28px; float: right; vertical-align: middle;">
                <div style="height: 24px; padding-top: 2px"> 
                <div style="width: 110px; display: inline-block; text-align:center;" >
                    <asp:TextBox ID="startDateTextBox" runat="server" Width="70px" Wrap="False">Start Date:</asp:TextBox>
                    <asp:ImageButton ID="imgPopup" ImageUrl="~/Pics/calendar.gif"
                            runat="server" Width="18px" ImageAlign="Middle" />
                    <cc1:CalendarExtender ID="startDateTextBox_CalendarExtender" runat="server" PopupButtonID="imgPopup" TargetControlID="startDateTextBox">
                    </cc1:CalendarExtender>
                </div>
                <div style="width: 110px; display: inline-block; text-align:center; ">
                    <asp:TextBox ID="endDateTextBox" runat="server" Width="70px" style="display: inline-block;" CssClass="lineup">End Date:</asp:TextBox>
                    <asp:ImageButton ID="imgPopup2" ImageUrl="~/Pics/calendar.gif"
                            runat="server" Width="18px" ImageAlign="Middle" />
                    <cc1:CalendarExtender ID="endDateTextBox_CalendarExtender" runat="server" PopupButtonID="imgPopup2" TargetControlID="endDateTextBox">
                    </cc1:CalendarExtender>
                </div>
                <div style="width: 120px; display: inline-block; background-color: #000; ">
                    <asp:DropDownList ID="hoursDropDownList" runat="server">
                        <asp:ListItem>07:00 - 06:59</asp:ListItem>
                        <asp:ListItem>00:00 - 23:59</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div style="width: 500px; display: inline-block; text-align:center;">
                    <asp:Label ID="Label1" runat="server" Text="Search Queue" ForeColor="White" BackColor="Black"></asp:Label>
                    <asp:DropDownList ID="groupDropDownList" runat="server" DataSourceID="SqlDataSource2" DataTextField="assignment_group" 
                        DataValueField="assignment_group">
                        <asp:ListItem Selected="True">TAC</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                        SelectCommand="select distinct(`assignment_group`) from servicenow_sla2"></asp:SqlDataSource>
                </div>
                <div style="width: 100px; display: inline-block; text-align:center; vertical-align: middle; ">

                    <asp:Button ID="searchButton" runat="server" Text="Search" style="display: inline-block;" OnClick="searchButton_Click"/>

                </div>
            </div>
            </div>
        <div>
            <hr />
        </div>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" Font-Overline="False" Font-Size="Smaller" CssClass="gridview" BackColor="#CCCCCC" 
            BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="2" CellSpacing="2" ForeColor="Black" OnRowDataBound="GridView1_RowDataBound" >
            <AlternatingRowStyle BackColor="#EEEEEE" />
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle HorizontalAlign="NotSet" VerticalAlign="NotSet" Wrap="False" BackColor="Black" Font-Bold="True" ForeColor="White" Height="200px" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand=""></asp:SqlDataSource>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    </div>
    </form>
    <footer style="position: absolute; bottom: 0; width: 99%; background-color: black; z-index: -1;">
        <asp:Label ID="copyLabel" runat="server" Text="©2015 NBC Universal - Developed by Josh Boley" ForeColor="White"></asp:Label>
    </footer>
</body>
</html>
