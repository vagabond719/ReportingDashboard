<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MetricsDashboard.Default" %>

<%--<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>--%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title></title>
    <link rel="stylesheet" type="text/css" href="StyleSheet1.css"/>
    <link href="dropdown-menu.css" media="screen" rel="stylesheet" type="text/css" />
    <meta name="description" content="The description of my page" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table class="auto-style2">
            <tr>
                <td style="width: 200px;">
                    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
                    
                    <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                        SelectCommand="select distinct(`assignment_group`) from servicenow_sla2"></asp:SqlDataSource>
                    
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Pics/Technology_logo_horz_bw.png" />
                </td>
                <td>
                    
                    <ul id="drop-nav">
                        <li><a href="#">Additional Pages</a>
                              <ul>
                                <li><a href="Aging.aspx" target="_blank">Aging Ticket Report</a></li>
                                <li><a href="Performance.aspx" target="_blank">Analyst Performance</a></li>
                                <li><a href="Charts.aspx" target="_blank">Monitoring Statistics</a></li>
                                <li><a href="ReOpen.aspx" target="_blank">ReOpens</a></li>
                                <li><a href="Misses.aspx" target="_blank">SLA Misses</a></li>
                                <li><a href="TopDrivers.aspx" target="_blank">Top Drivers</a></li>
                                <li><a href="VOC.aspx" target="_blank">VOC</a></li>
                            </ul>
                          </li>
                    </ul>
                    <div class="LikeUL">
                        Search Queue 
                            <asp:DropDownList ID="queueDropDownList" runat="server" DataSourceID="SqlDataSource8" DataTextField="assignment_group" 
                                    DataValueField="assignment_group" AutoPostBack="True">
                            </asp:DropDownList>
                    </div>
                </td>
                <td style="width: 20px">
                    
                </td>
            </tr>
        </table>
        
        <hr />
        <div style="width: 800px; display: inline-block;">
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand=""></asp:SqlDataSource>
        <h2 class="label"><strong>Request\Incidents</strong></h2>
            <hr />
            <asp:Label ID="Label2" runat="server" Text="Daily" CssClass="label"></asp:Label>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" OnRowDataBound="GridView1_RowDataBound" CssClass="mGrid" >
            <Columns>
                <asp:BoundField DataField="Date" HeaderText="Date" />
                <asp:BoundField DataField="INCMade" HeaderText="INCMade" />
                <asp:BoundField DataField="INCMissed" HeaderText="INCMissed" />
                <asp:BoundField DataField="INCSLA" HeaderText="INCSLA" ReadOnly="True"/>
                <asp:BoundField DataField="INCReopen" HeaderText="INCReopen" />
                <asp:BoundField DataField="RITMMade" HeaderText="RITMMade" />
                <asp:BoundField DataField="RITMMissed" HeaderText="RITMMissed" />
                <asp:BoundField DataField="RITMSLA" HeaderText="RITMSLA" ReadOnly="True" />
                <asp:BoundField DataField="RITMReopen" HeaderText="RITMReopen" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
            <RowStyle HorizontalAlign="Center" />
        </asp:GridView>
        <hr />
            <asp:Label ID="Label3" runat="server" Text="MTD" CssClass="label"></asp:Label>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" CssClass="mGrid" OnRowDataBound="GridView2_RowDataBound" >
            <Columns>
                <asp:BoundField DataField="Date" HeaderText="Date" />
                <asp:BoundField DataField="TotalMade" HeaderText="TotalMade" ReadOnly="True" />
                <asp:BoundField DataField="TotalMissed" HeaderText="TotalMissed" ReadOnly="True" />
                <asp:BoundField DataField="TotalSLA" HeaderText="TotalSLA" ReadOnly="True" />
                <asp:BoundField DataField="TotalReopen" HeaderText="TotalReopen" ReadOnly="True" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
            <RowStyle HorizontalAlign="Center" />
        </asp:GridView>
        <hr />
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand=""></asp:SqlDataSource>
            <asp:Label ID="Label4" runat="server" Text="Aging Tickets" CssClass="label"></asp:Label>
         <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" CssClass="mGrid" >
            <Columns>
                <asp:BoundField DataField="Aver" HeaderText="Daily Average" />
                <asp:BoundField DataField="ToBeWorked" HeaderText="Tickets To BeWorked" />
                <asp:BoundField DataField="DaysWork" HeaderText="Estimated Days Of Work" ReadOnly="True" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
             <RowStyle HorizontalAlign="Center" />
        </asp:GridView>
    <hr />
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand=""></asp:SqlDataSource>
            <asp:Label ID="Label5" runat="server" Text="Aging Tickets in the Queue" CssClass="label"></asp:Label>
        <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource4" CssClass="mGrid" >
            <Columns>
                <asp:BoundField DataField="&lt; 3" HeaderText="&lt; 3 Days" />
                <asp:BoundField DataField="4-7" HeaderText="4-7 Days" />
                <asp:BoundField DataField="8-15" HeaderText="8-15 Days" />
                <asp:BoundField DataField="16-30" HeaderText="16-30 Days" />
                <asp:BoundField DataField="&gt; 31" HeaderText="&gt; 31 Days" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="White" />
            <RowStyle HorizontalAlign="Center" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand=""></asp:SqlDataSource>
        </div>
        <div style="width: 500px; display: inline-block; vertical-align: top">
            <h2 class="label"><strong>Change\CTASK Stats</strong></h2>  
        <hr />
            <asp:Label ID="Label7" runat="server" Text="Due Today" CssClass="label"></asp:Label>
            <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource5" CssClass="mGrid">
            <Columns>
                <asp:BoundField DataField="state" HeaderText="State" />
                <asp:BoundField DataField="priority" HeaderText="Priority" />
                <asp:BoundField DataField="Tally" HeaderText="Tally" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
            <RowStyle HorizontalAlign="Center" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" ></asp:SqlDataSource>
            <hr />
            <asp:Label ID="Label1" runat="server" Text="Closed Yesterday" CssClass="label"></asp:Label>
            <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource6" CssClass="mGrid" >
            <Columns>
                <asp:BoundField DataField="state" HeaderText="State" />
                <asp:BoundField DataField="Tally" HeaderText="Tally" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
            <RowStyle HorizontalAlign="Center" />
        </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" ></asp:SqlDataSource>
            <hr />
            <asp:Label ID="Label6" runat="server" Text="Aging Tickets" CssClass="label"></asp:Label>
                    <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource7" CssClass="mGrid" >
                        <Columns>
                            <asp:BoundField DataField="counts" HeaderText="counts" Visible="False" />
                            <asp:BoundField DataField="&lt; 3" HeaderText="&lt; 3 days" />
                            <asp:BoundField DataField="4-7" HeaderText="4-7 days" />
                            <asp:BoundField DataField="8-15" HeaderText="8-15 days" />
                            <asp:BoundField DataField="16-30" HeaderText="16-30 days" />
                            <asp:BoundField DataField="&gt; 31" HeaderText="&gt; 31 days" />
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                        <RowStyle BackColor="White" />
                        <RowStyle HorizontalAlign="Center" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" ></asp:SqlDataSource>
        </div>
    </div>
    </form>
    <footer style="position: absolute; bottom: 0; width: 99%; background-color: black; z-index: -1;">
        <asp:Label ID="copyLabel" runat="server" Text="©2015 NBC Universal - Developed by Josh Boley" ForeColor="White"></asp:Label>
    </footer>
</body>
</html>
