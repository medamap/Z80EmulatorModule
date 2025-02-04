namespace z80.core.cpu;

public class Registers
{
    public byte A { get; set; }  // アキュムレータ
    public byte F { get; set; }  // フラグレジスタ
    public byte B { get; set; }
    public byte C { get; set; }
    public byte D { get; set; }
    public byte E { get; set; }
    public byte H { get; set; }
    public byte L { get; set; }

    public ushort SP { get; set; }  // スタックポインタ
    public ushort PC { get; set; }  // プログラムカウンタ

    // フラグ管理用
    public bool Carry => (F & 0x01) != 0;
    public bool Zero => (F & 0x40) != 0;
}
