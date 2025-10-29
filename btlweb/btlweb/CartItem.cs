using System;

namespace btlweb
{
    [Serializable]
    public class CartItem
    {
        public int MaSP { get; set; }
        public string TenSP { get; set; }
        public string Anh { get; set; }
        public string MoTaNgan { get; set; }
        public decimal Gia { get; set; }
        public int Qty { get; set; }
    }
}
