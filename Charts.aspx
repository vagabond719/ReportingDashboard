<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Charts.aspx.cs" Inherits="MetricsDashboard.WebForm1" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        body {
           background-color: #4C4C4C;
        }
    </style>
    </head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:SqlDataSource 
            ID="SqlDataSource1" 
            runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
            SelectCommand="select distinct(alerttype), count(alerttype) from alerts where date &gt;= '2015-05-18 00:00:00' and date &lt;= '2015-05-19 00:00:00'  group by alerttype"
        ></asp:SqlDataSource>
                    <asp:SqlDataSource 
                        ID="SqlDataSource2" 
                        runat="server" 
                        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                        SelectCommand="select device, count(device) as alerts, alerttype, description from Alerts where status = 'Test'"
                    ></asp:SqlDataSource>

                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                        SelectCommand="select mid(date,1,10) as ShortDate, count(mid(date,1,10)) as Tally from 
                            alerts where alerttype = 'Test' and date like '2015-05%' group by mid(date,1,10)"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
            SelectCommand="select alerttype, description, count(*) as tally from alerts where alerttype = 'Test' group by alerttype, description"></asp:SqlDataSource>
                    
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <table>
            <tr>
                <td>
                    <asp:TextBox ID="startDateTextBox" runat="server" BackColor="#4D4D4D" ForeColor="White" Width="82px">Start Date:</asp:TextBox>
                    <cc1:CalendarExtender ID="CalendarExtender1" PopupButtonID="imgPopup" runat="server" TargetControlID="startDateTextBox"
                                          Format="yyyy-MM-dd">
                    </cc1:CalendarExtender>
                    <asp:ImageButton ID="imgPopup" runat="server" ImageAlign="Right" ImageUrl="~/Pics/calendar.gif" Width="18px" />
                </td>
                <td>
                    <asp:TextBox ID="endDateTextBox" runat="server" Width="82px" BackColor="#4D4D4D" ForeColor="White">End Date:</asp:TextBox>
                    <asp:ImageButton ID="imgPopup2" ImageUrl="~/Pics/calendar.gif" ImageAlign="Right"
                                     runat="server" Width="18px"/>
                    <cc1:CalendarExtender ID="CalendarExtender2" PopupButtonID="imgPopup2" runat="server" TargetControlID="endDateTextBox"
                                          Format="yyyy-MM-dd">
                    </cc1:CalendarExtender>
                </td>
                <td>
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Run Query" />
                </td>
            </tr>
        </table>
          <table>
            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server" Text="Volume Trends" Font-Bold="True" ForeColor="White"></asp:Label>
                    <br/>
                    <asp:Chart ID="Chart2" runat="server" DataSourceID="SqlDataSource3" Height="300px" Width="620px" BackColor="LightGray">
                        <Series>
                            <asp:Series ChartType="Line" Name="Series1" XValueMember="ShortDate" YValueMembers="Tally" Legend="Legend1" ChartArea="ChartArea1">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="True"  WallWidth="10" />  
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>
                </td>
                <td>
                     <asp:Label ID="Label2" runat="server" Text="Top Offenders By Device" Font-Bold="True" ForeColor="White"></asp:Label>
                    <div style="width: 100%; height: 300px; width: 620px; overflow: scroll">
                       
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" Width="600px" BackColor="#CCCCCC" 
                                BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="2" CellSpacing="2" ForeColor="Black" Font-Size="Smaller">
                                <AlternatingRowStyle BackColor="#EEEEEE" />
                                <Columns>
                                    <asp:BoundField DataField="Device" HeaderText="Device" />
                                    <asp:BoundField DataField="alerts" HeaderText="Alerts" />
                                    <asp:BoundField DataField="alerttype" HeaderText="Alerttype"/>
                                    <asp:BoundField DataField="description" HeaderText="Description"/>
                                </Columns>
                                <FooterStyle BackColor="#CCCCCC" />
                                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                <rowstyle backcolor="White"/>
                            </asp:GridView>
                        </div>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label3" runat="server" Text="Volume By Alert Type" Font-Bold="True" ForeColor="White"></asp:Label>
                    <br/>
                    <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1" Height="300px" Width="620px" BackColor="LightGray" style="margin-right: 0">
                        <series>
                            <asp:Series ChartType="Column" >
                            </asp:Series>
                        </series>
                        <chartareas>
                            <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="true"  WallWidth="10" />  
                            </asp:ChartArea>
                        </chartareas>
                    </asp:Chart>
                </td>
                <td>
                    <asp:Label ID="Label4" runat="server" Text="Top Offenders By Alert Type" Font-Bold="True" ForeColor="White"></asp:Label>
                    <div style="width: 100%; height: 300px; width: 620px; overflow: scroll">
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource4" ScrollBars="Vertical" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" Width="600px" CellSpacing="2" ForeColor="Black" Font-Size="Smaller" >
                            <AlternatingRowStyle BackColor="#EEEEEE" />
                            <Columns>
                                <asp:BoundField DataField="alerttype" HeaderText="Alerttype"/>
                                <asp:BoundField DataField="description" HeaderText="Description"/>
                                <asp:BoundField DataField="tally" HeaderText="Tally"/>
                            </Columns>
                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                        </asp:GridView>
                    </div>
                </td>
            </tr>
              <tr>
                <td style="vertical-align:top;">
                    <asp:Label ID="Label5" runat="server" Font-Bold="True" ForeColor="White" Text="Repeatable Event Trending"></asp:Label>
                    <div style="width: 100%; height: 300px; width: 620px; overflow: scroll">
                        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" 
                            CellPadding="2" CellSpacing="2" DataSourceID="SqlDataSource5" Font-Size="Smaller" ForeColor="Black" ScrollBars="Vertical" Width="600px" 
                            OnRowDataBound="GridView3_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="Device" HeaderText="Device" />
                                <asp:BoundField DataField="Hours" HeaderText="Hours" />
                                <asp:BoundField DataField="Mon" HeaderText="M" />
                                <asp:BoundField DataField="Tue" HeaderText="T" />
                                <asp:BoundField DataField="Wed" HeaderText="W" />
                                <asp:BoundField DataField="Thu" HeaderText="T" />
                                <asp:BoundField DataField="Fri" HeaderText="F" />
                                <asp:BoundField DataField="Sat" HeaderText="S" />
                                <asp:BoundField DataField="Sun" HeaderText="S" />
                                <asp:BoundField DataField="Total" HeaderText="Total" />
                                <asp:BoundField DataField="Description" HeaderText="Description" />
                                <asp:BoundField DataField="AlertType" HeaderText="AlertType" />
                            </Columns>
                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="select * from trending_report"></asp:SqlDataSource>
                    </div>
                </td>
                <td>
                    <asp:Label ID="Label6" runat="server" Font-Bold="True" ForeColor="White" Text="Top Offenders Of Repeatable Events"></asp:Label>
                    <div style="width: 100%; height: 300px; width: 620px; overflow: scroll">
                        
                        <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource6" ScrollBars="Vertical" BackColor="#CCCCCC" 
                            BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" Width="600px" CellSpacing="2" ForeColor="Black" Font-Size="Smaller" >
                            <AlternatingRowStyle BackColor="#EEEEEE" />
                            <Columns>
                                <asp:BoundField DataField="device" HeaderText="Device"/>
                                <asp:BoundField DataField="sum(total)" HeaderText="Tally" />
                            </Columns>
                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                            <RowStyle BackColor="White" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                            ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" 
                            SelectCommand="select device, sum(total) from trending_report group by device having sum(total) &gt; 2 order by sum(total) desc"></asp:SqlDataSource>
                    </div>    
                    </td>
            </tr>
        </table>
    </div>
    </form>
    <footer style="width: 99%; background-color: black;">
        <asp:Label ID="copyLabel" runat="server" Text="©2015 NBC Universal - Developed by Josh Boley" ForeColor="White"></asp:Label>
    </footer>
</body>
</html>