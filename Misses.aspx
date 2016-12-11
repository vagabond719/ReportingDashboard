<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Misses.aspx.cs" Inherits="MetricsDashboard.Misses" EnableViewState="true" ViewStateEncryptionMode="Always" 
    EnableSessionState="True" %>

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
                                <li><a href="TopDrivers.aspx" target="_blank">Top Drivers</a></li>
                                <li><a href="VOC.aspx" target="_blank">VOC</a></li>
                            </ul>
                          </li>
                        <li>
                            <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" RepeatDirection="Horizontal" BackColor="Black" CellPadding="2" 
                                CellSpacing="2" ForeColor="White">
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
                <td colspan="4"><hr/></td></tr>
        </table>
        <table class="auto-style1">
            <tr>
                <td>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="mGrid" BackColor="#CCCCCC" 
                        BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="2" CellSpacing="2" ForeColor="Black" OnRowUpdating="GridView1_RowUpdating">
                        <AlternatingRowStyle BackColor="#EEEEEE" />
                        <Columns>
                            <asp:TemplateField HeaderText="Number">
	                            <ItemTemplate>
                                    <asp:HyperLink runat="server">
                                        <a href='<%# Eval("Number", @"https://nbcu.service-now.com/do/incident.do?sysparm_query=number={0}") %>' target="_blank"
                                            id='<%# Eval("Number") %>'><%# Eval("Number") %></a>
                                        </asp:HyperLink>
                                </ItemTemplate>
		                        <EditItemTemplate>
                                    <asp:Label ID="NumberLabel" runat="server" Text='<%# Eval("Number") %>' ></asp:Label>
		                        </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Owner" HeaderText="Owner" ReadOnly="true"  />
                            <asp:BoundField DataField="Stage" HeaderText="Stage" ReadOnly="true"  />
                            <asp:BoundField DataField="Desciption" HeaderText="Desciption" ReadOnly="true"  />
                            <asp:BoundField DataField="Updated" HeaderText="Updated" ReadOnly="true"  />
                            <asp:BoundField DataField="State" HeaderText="State" ReadOnly="true"  />
                            <asp:TemplateField HeaderText="ADJ_SLA">
		                        <EditItemTemplate>
			                        <asp:DropDownList ID="SLA_List" runat="server">
			                            <asp:ListItem>Made</asp:ListItem>
                                        <asp:ListItem>Missed Analyst</asp:ListItem>
                                        <asp:ListItem>Missed Process</asp:ListItem>
                                        <asp:ListItem>Missed Transfer</asp:ListItem>
			                        </asp:DropDownList>
		                        </EditItemTemplate>
		                        <ItemTemplate>
			                        <asp:Label ID="ADJ_SLALabel" runat="server" Text='<%# Eval("ADJ_SLA") %>'></asp:Label>
                                </ItemTemplate>
                        	</asp:TemplateField>
                            <asp:TemplateField HeaderText="ADJ_Comment">
		                        <EditItemTemplate>
                                    <asp:TextBox ID="ADJ_CommentTextBox" runat="server" Text='<%# Eval("ADJ_Comment") %>'></asp:TextBox>
		                        </EditItemTemplate>
		                        <ItemTemplate>
			                        <asp:Label ID="ADJ_CommentLabel" runat="server" Text='<%# Eval("ADJ_Comment") %>'></asp:Label>
                                </ItemTemplate>
                        	</asp:TemplateField>
                            <asp:BoundField DataField="Modified By" HeaderText="Modified By" ReadOnly="true"  />
                            <asp:CommandField ShowEditButton="True" />
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                        <RowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT `number` AS Number, `assigned_to` AS Owner, `state` AS Stage, `short_description` AS Desciption, `sys_updated_on` AS Updated, `close_code` AS State, ADJ_SLA, ADJ_Comment, `Modified By` FROM servicenow_sla2 WHERE (`resolved_at` &gt;= CONCAT(CURDATE() - INTERVAL 30 DAY, ' 00:00:00')) AND (`assignment_group` LIKE ? ) AND (`close_code` NOT LIKE '%cancelled%') AND (has_breached = 'true') and type = 'INC' ORDER BY Updated DESC" >
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList1" DefaultValue="%tac%" Name="column1" PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td>
                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" CssClass="mGrid" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="2" CellSpacing="2" ForeColor="Black">
                        <AlternatingRowStyle BackColor="#EEEEEE" />
                        <Columns>
                            <asp:TemplateField HeaderText="Number">
	                            <ItemTemplate>
                                    <asp:HyperLink runat="server">
                                        <a href='<%# Eval("Number", @"https://nbcu.service-now.com/do/incident.do?sysparm_query=number={0}") %>' target="_blank"
                                            id='<%# Eval("Number") %>'><%# Eval("Number") %></a>
                                        </asp:HyperLink>
                                </ItemTemplate>
		                        <EditItemTemplate>
                                    <asp:Label ID="NumberLabel" runat="server" Text='<%# Eval("Number") %>' ></asp:Label>
		                        </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Owner" HeaderText="Owner" ReadOnly="true"  />
                            <asp:BoundField DataField="Stage" HeaderText="Stage" ReadOnly="true"  />
                            <asp:BoundField DataField="Desciption" HeaderText="Desciption" ReadOnly="true"  />
                            <asp:BoundField DataField="Updated" HeaderText="Updated" ReadOnly="true"  />
                            <asp:BoundField DataField="State" HeaderText="State" ReadOnly="true"  />
                            <asp:TemplateField HeaderText="ADJ_SLA">
		                        <EditItemTemplate>
			                        <asp:DropDownList ID="SLA_List" runat="server">
			                            <asp:ListItem>Made</asp:ListItem>
                                        <asp:ListItem>Missed Analyst</asp:ListItem>
                                        <asp:ListItem>Missed Process</asp:ListItem>
                                        <asp:ListItem>Missed Transfer</asp:ListItem>
			                        </asp:DropDownList>
		                        </EditItemTemplate>
		                        <ItemTemplate>
			                        <asp:Label ID="ADJ_SLALabel" runat="server" Text='<%# Eval("ADJ_SLA") %>'></asp:Label>
                                </ItemTemplate>
                        	</asp:TemplateField>
                            <asp:TemplateField HeaderText="ADJ_Comment">
		                        <EditItemTemplate>
                                    <asp:TextBox ID="ADJ_CommentTextBox" runat="server" Text='<%# Eval("ADJ_Comment") %>'></asp:TextBox>
		                        </EditItemTemplate>
		                        <ItemTemplate>
			                        <asp:Label ID="ADJ_CommentLabel" runat="server" Text='<%# Eval("ADJ_Comment") %>'></asp:Label>
                                </ItemTemplate>
                        	</asp:TemplateField>
                            <asp:BoundField DataField="Modified By" HeaderText="Modified By" ReadOnly="true"  />
                            <asp:CommandField ShowEditButton="True" />
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                        <RowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                        SelectCommand="SELECT `number` AS Number, `assigned_to` AS Owner, `state` AS Stage, 
                        `short_description` AS Desciption, `sys_updated_on` AS Updated, `close_code` AS State, ADJ_SLA, ADJ_Comment, 
                        `Modified By` FROM servicenow_sla2 WHERE (`resolved_at` &gt;= CONCAT(CURDATE() - INTERVAL 30 DAY, ' 00:00:00')) AND 
                        (`assignment_group` LIKE ? ) AND (`close_code` NOT LIKE '%cancelled%') AND (has_breached = 'true') and type = 'RIT' ORDER BY Updated DESC" >
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList1" DefaultValue="%tac%" Name="column1" PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </div>
    </form>
    <footer style="position: absolute; bottom: 57px; width: 99%; background-color: black; z-index: -1; left: 10px;">
        <asp:Label ID="copyLabel" runat="server" Text="©2015 NBC Universal - Developed by Josh Boley" ForeColor="White"></asp:Label>
    </footer>
</body>
</html>
