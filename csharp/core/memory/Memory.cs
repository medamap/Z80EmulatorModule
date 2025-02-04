namespace z80.core.memory;

public class Memory
{
    private byte[] ram;

    public Memory()
    {
        ram = new byte[65536]; // Z80 のメモリ空間 (64KB)
    }

    public byte ReadByte(ushort address)
    {
        return ram[address];
    }

    public void WriteByte(ushort address, byte value)
    {
        ram[address] = value;
    }
}
