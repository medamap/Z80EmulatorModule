namespace z08.core.cpu;

public class Decoder
{
    public static string Decode(byte opcode)
    {
        return opcode switch
        {
            0x00 => "NOP",
            0x01 => "LD BC,nn",
            0x02 => "LD (BC),A",
            0x03 => "INC BC",
            0x04 => "INC B",
            0x05 => "DEC B",
            0x06 => "LD B,n",
            0x07 => "RLCA",
            0x08 => "EX AF,AF'",
            0x09 => "ADD HL,BC",
            0x0A => "LD A,(BC)",
            0x0B => "DEC BC",
            _ => "UNKNOWN"
        };
    }
}
