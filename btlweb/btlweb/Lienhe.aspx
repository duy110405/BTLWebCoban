<%@ Page Title="" Language="C#" MasterPageFile="~/khung.Master" AutoEventWireup="true" CodeBehind="Lienhe.aspx.cs" Inherits="btlweb.Lienhe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/Lienhe.css" />
    <script>
        function checkDuLieuNhap() {
            var name = document.getElementById('<%= txtFullName.ClientID %>').value.trim();
           var email = document.getElementById('<%= txtEmail.ClientID %>').value.trim();
           var phone = document.getElementById('<%= txtPhone.ClientID %>').value.trim();
           var message = document.getElementById('<%= txtMessage.ClientID %>').value.trim();

    // Lấy các label lỗi
    var errName = document.getElementById('<%= errFullName.ClientID %>');
    var errEmail = document.getElementById('<%= errEmail.ClientID %>');
    var errPhone = document.getElementById('<%= errPhone.ClientID %>');
            var errMessage = document.getElementById('<%= errMessage.ClientID %>');

            // Ẩn tất cả lỗi trước
            errName.style.display = 'none';
            errEmail.style.display = 'none';
            errPhone.style.display = 'none';
            errMessage.style.display = 'none';

            var isValid = true;

            if (name === "") {
                errName.style.display = 'block';
                isValid = false;
            }

            if (email === "") {
                errEmail.style.display = 'block';
                isValid = false;
            }

            if (phone === "") {
                errPhone.style.display = 'block';
                isValid = false;
            }

            if (message === "") {
                errMessage.style.display = 'block';
                isValid = false;
            }

            return isValid; // Nếu false thì form sẽ không submit
        }

    </script>
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
          <asp:Label ID="errFullName" runat="server" CssClass="error" Text="Họ tên không được để trống" Visible="false" />

          <asp:TextBox ID="txtEmail" runat="server" Placeholder="Email"></asp:TextBox>
           <asp:Label ID="errEmail" runat="server" CssClass="error" Text="email không được để trống" Visible="false" />

          <asp:TextBox ID="txtPhone" runat="server" Placeholder="Điện thoại*"></asp:TextBox>
           <asp:Label ID="errPhone" runat="server" CssClass="error" Text="số điện thoại không được để trống" Visible="false" />

          <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Placeholder="Nội dung"></asp:TextBox> 
          <asp:Label ID="errMessage" runat="server" CssClass="error" Text="tin nhắn không được để trống" Visible="false" />
        
      </div>
        <asp:Label ID="lblStatusMessage" runat="server" ForeColor="green" />
        <asp:Button ID="btnGuiYeuCau" runat="server" Text="Gửi Thông Tin " OnClick="btnGuiYeuCau_Click" OnClientClick="return checkDuLieuNhap();"  />
   </div>
    </div>
    
</asp:Content>
