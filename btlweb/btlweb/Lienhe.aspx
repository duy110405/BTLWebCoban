<%@ Page Title="" Language="C#" MasterPageFile="~/khung.Master" AutoEventWireup="true" CodeBehind="Lienhe.aspx.cs" Inherits="btlweb.Lienhe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/Lienhe.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="lienHeWrapper">
        <img src="anh/mapcuahang.png" alt="Ảnh map cửa hàng "/>

         <div class="thongTin">
             <p><b>HOUCOMPUTER</b></p><br />
             <p><b>Địa chỉ:</b> 96 P. Định Công, Phương Liệt, Thanh Xuân, Hà Nội </p><br />
             <p><b>Email:</b> Houcomputer@gmail.com</p><br />
             <p><b>Hotline:</b> 0987654321</p><br />
             <p><b>LIÊN HỆ VỚI CHÚNG TÔI</b></p><br />

      <div class="nhapTT">
          <asp:TextBox ID="txtFullName" runat="server" Placeholder="Họ và tên"></asp:TextBox>
          <asp:TextBox ID="txtEmail" runat="server" Placeholder="Email"></asp:TextBox>
          <asp:TextBox ID="txtPhone" runat="server" Placeholder="Điện thoại*"></asp:TextBox>
          <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Placeholder="Nội dung"></asp:TextBox>          
      </div>
        <asp:Label ID="lblStatusMessage" runat="server" ForeColor="green" />
        <asp:Button ID="btnGuiYeuCau" runat="server" Text="Gửi Thông Tin " OnClick="btnGuiYeuCau_Click" />
    </div>


    </div>
    
</asp:Content>
