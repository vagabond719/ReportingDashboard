<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VOC.aspx.cs" Inherits="MetricsDashboard.Voc" %>

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
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
                                  <li><a href="VOC.aspx" target="_blank">VOC</a></li>
                            </ul>
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
                <td colspan="3"><hr/></td>
            </tr>
        </table>
        <table style="width: 100%; padding-bottom: 30px;">
            <tr>
                <td>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="mGrid" BackColor="#CCCCCC" 
                        BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="2" CellSpacing="2" ForeColor="Black" Font-Size="Smaller" 
                        OnRowDataBound="GridView1_RowDataBound" AllowPaging="True" PageSize="20">
                        <Columns>
                            <asp:BoundField DataField="u_request_no" HeaderText="Ticket" />
                            <asp:BoundField DataField="u_owner" HeaderText="Owner" />
                            <asp:BoundField DataField="u_issue_fulfilled" HeaderText="Res" />
                            <asp:BoundField DataField="u_first_case" HeaderText="FTR" />
                            <asp:BoundField DataField="u_contacted" HeaderText="FTC" />
                            <asp:BoundField DataField="u_satisfaction" HeaderText="CS" />
                            <asp:BoundField DataField="u_exp_tech" HeaderText="CE" />
                            <asp:BoundField DataField="u_kept_informed" HeaderText="CS" />
                            <asp:BoundField DataField="u_tech_skills" HeaderText="KP" />
                            <asp:BoundField DataField="u_customer_skills" HeaderText="Pro" />
                            <asp:BoundField DataField="u_resolved_time" HeaderText="Time" />
                            <asp:BoundField DataField="u_comments" HeaderText="Comments" ItemStyle-Width="250px" />
                            <asp:BoundField DataField="u_group" HeaderText="Group" />
                            <asp:BoundField DataField="u_groupparent" HeaderText="Parent" />
                            <asp:BoundField DataField="u_caller" HeaderText="Caller" />
                            <asp:BoundField DataField="u_calleru_organization_segment" HeaderText="Org" />
                            <asp:BoundField DataField="u_calleru_sub_organization_segment" HeaderText="SubOrg" />
                            <asp:BoundField DataField="u_requestor_for" HeaderText="Customer" />
                            <asp:BoundField DataField="sys_created_on" HeaderText="Created" />
                            <asp:BoundField DataField="RefID" HeaderText="RefID" InsertVisible="False" ReadOnly="True" Visible="False"/>
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                        <RowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"></asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </div>
    </form>
    <footer style="position: absolute; bottom: 0; width: 99%; background-color: black; z-index: -1; height: 30px">
        <asp:Label ID="copyLabel" runat="server" Text="©2015 NBC Universal - Developed by Josh Boley" ForeColor="White"></asp:Label>
    </footer>
</body>
</html>
