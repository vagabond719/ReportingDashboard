<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReOpen.aspx.cs" Inherits="MetricsDashboard.ReOpen" %>

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
        <table class="auto-style1">
            <tr>
                <td>
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
                        <li>
                             <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged" 
                                 RepeatDirection="Horizontal" BackColor="Black" CellPadding="2" CellSpacing="2" ForeColor="White">
                                <asp:ListItem>INC</asp:ListItem>
                                <asp:ListItem>RITM</asp:ListItem>
                            </asp:RadioButtonList>
                        </li>
                    </ul>
                    <div class="LikeUL">
                        Search Queue 
                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource5" DataTextField="assignment_group" 
                                    DataValueField="assignment_group" AutoPostBack="True">
                            </asp:DropDownList>
                    </div>
                    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                        SelectCommand="select distinct(`assignment_group`) from servicenow_sla2"></asp:SqlDataSource>
                </td>
                <td style="width: 20px">
                    
                </td>
            </tr>
            <tr>
                <td colspan="4"><hr/></td>
            </tr>
        </table>
        <table class="auto-style1">
            <tr>
                <td>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="mGrid" BackColor="#CCCCCC" 
                        BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="2" CellSpacing="2" ForeColor="Black">
                        <AlternatingRowStyle BackColor="#EEEEEE" />
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="Number"
                                        DataNavigateUrlFormatString="https://nbcu.service-now.com/do/incident.do?sysparm_query=number={0}"
                                        DataTextField="Number" HeaderText="TicketNumber" NavigateUrl="https://nbcu.service-now.com/do/incident.do?sysparm_query=number={0}"
                                        SortExpression="Device" Target="_blank"/>
                            <asp:BoundField DataField="Owner" HeaderText="Owner" />
                            <asp:BoundField DataField="Stage" HeaderText="Stage" />
                            <asp:BoundField DataField="Desciption" HeaderText="Desciption" />
                            <asp:BoundField DataField="Updated" HeaderText="Updated" />
                            <asp:BoundField DataField="State" HeaderText="State" />
                            <asp:BoundField DataField="ReOpen" HeaderText="ReOpen" />
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                        <RowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"></asp:SqlDataSource>
                </td>
                <td>
                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" CssClass="mGrid" BackColor="#CCCCCC" 
                        BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="2" CellSpacing="2" ForeColor="Black">
                        <AlternatingRowStyle BackColor="#EEEEEE" />
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="Number"
                                        DataNavigateUrlFormatString="https://nbcu.service-now.com/do/sc_req_item.do?sysparm_query=number={0}"
                                        DataTextField="Number" HeaderText="TicketNumber" NavigateUrl="https://nbcu.service-now.com/do/sc_req_item.do?sysparm_query=number={0}"
                                        SortExpression="Device" Target="_blank"/>
                            <asp:BoundField DataField="Owner" HeaderText="Owner" />
                            <asp:BoundField DataField="Stage" HeaderText="Stage" />
                            <asp:BoundField DataField="Desciption" HeaderText="Desciption" />
                            <asp:BoundField DataField="Updated" HeaderText="Updated" />
                            <asp:BoundField DataField="State" HeaderText="State"  />
                            <asp:BoundField DataField="ReOpen" HeaderText="ReOpen" />
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                        <RowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" ></asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </div>
    </form>
    <footer style="position: absolute; bottom: 0; width: 99%; background-color: black; z-index: -1;">
        <asp:Label ID="copyLabel" runat="server" Text="©2015 NBC Universal - Developed by Josh Boley" ForeColor="White"></asp:Label>
    </footer>
</body>
</html>
