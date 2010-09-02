<%@ Page Language="C#" Inherits="Orchard.Mvc.ViewPage<UsersIndexViewModel>" %>
<%@ Import Namespace="Orchard.Users.Models" %>
<%@ Import Namespace="Orchard.Users.ViewModels"%>
<h1><%: Html.TitleForPage(T("Manage Users").ToString()) %></h1>
<% using (Html.BeginFormAntiForgeryPost()) { %>
    <%: Html.ValidationSummary()%>
    <div class="manage"><%: Html.ActionLink(T("Add a new user").ToString(), "Create", new { }, new { @class = "button primaryAction" })%></div>
    <fieldset>
        <table class="items">
            <colgroup>
                <col id="Name" />
                <col id="Email" />
                <col id="Edit" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col"><%: T("Name")%></th>
                    <th scope="col"><%: T("Email")%></th>
                    <th scope="col"><%: T("") %></th>
                </tr>
            </thead>
            <% foreach (var row in Model.Rows)
               { %>
            <tr>
                <td>
                    <% if(row.UserPart.RegistrationStatus == UserStatus.Approved) { %>
                    <img class="icon" src="<%=ResolveUrl("~/Modules/Orchard.Users/Content/Admin/images/online.gif") %>" alt="<%:T("Approved") %>" title="<%:T("User is approved") %>" /> 
                    <% } 
                    else { %>
                    <img class="icon" src="<%=ResolveUrl("~/Modules/Orchard.Users/Content/Admin/images/offline.gif") %>" alt="<%:T("Moderated") %>" title="<%:T("User is moderated") %>" />
                    <% } %>
                    <%: row.UserPart.UserName %>
                </td>
                <td>
                    <%: row.UserPart.Email %>
                </td>
                <td>
                    <%: Html.ActionLink(T("Edit").ToString(), "Edit", new { row.UserPart.Id })%> | 
                    <%: Html.ActionLink(T("Remove").ToString(), "Delete", new { row.UserPart.Id })%> | 
                    <%: row.UserPart.RegistrationStatus == UserStatus.Pending ? Html.ActionLink(T("Approve").ToString(), "Approve", new { row.UserPart.Id }) : Html.ActionLink(T("Disable").ToString(), "Moderate", new { row.UserPart.Id })%>
                    <% if ( row.UserPart.EmailStatus == UserStatus.Pending ) { %> | 
                        <%: Html.ActionLink(T("Challenge Email").ToString(), "SendChallengeEmail", new { row.UserPart.Id })%>
                    <% } %>
                </td>
            </tr>
            <%}%>
        </table>
    </fieldset>
<% } %>