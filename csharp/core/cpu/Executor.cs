using z80.core.memory;

namespace z80.core.cpu;

public class Executor
{
    private readonly Registers registers;
    private readonly Memory memory;

    public Executor(Registers registers, Memory memory)
    {
        this.registers = registers;
        this.memory = memory;
    }

    public void Execute(byte opcode)
    {
        switch (opcode)
        {
            case 0x00:  // NOP
                break;

            case 0x01:  // LD BC,nn
                registers.C = FetchNextByte();
                registers.B = FetchNextByte();
                break;

            case 0x02:  // LD (BC),A (メモリアクセスは後ほど)
                memory.WriteByte((ushort)((registers.B << 8) | registers.C), registers.A);
                break;

            case 0x03:  // INC BC
                ushort bc = (ushort)((registers.B << 8) | registers.C);
                bc++;
                registers.B = (byte)(bc >> 8);
                registers.C = (byte)(bc & 0xFF);
                break;

            case 0x04:  // INC B
                registers.B++;
                break;

            case 0x05:  // DEC B
                registers.B--;
                break;

            case 0x06:  // LD B,n
                registers.B = FetchNextByte();
                break;

            case 0x07:  // RLCA
                registers.A = (byte)((registers.A << 1) | (registers.A >> 7));
                break;

            case 0x0A:  // LD A,(BC)
                registers.A = memory.ReadByte((ushort)((registers.B << 8) | registers.C));
                break;

            default:
                throw new NotImplementedException($"Opcode {opcode:X2} is not implemented.");
        }
    }

    private byte FetchNextByte()
    {
        byte value = memory.ReadByte(registers.PC);
        registers.PC++;
        return value;
    }
}
