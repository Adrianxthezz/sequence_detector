// ================================================================
// Máquina de Estados de Mealy de 8 estados (3 Flip-Flops)
// ================================================================
// Autor: Adrián Trejo
// Descripción: FSM de Mealy
// ================================================================

module fsm (
    input  wire clk_i,       // reloj
    input  wire rst_i,       // reset asíncrono activo en bajo
    input  wire x_i,         // entrada
    output reg  y_o          // salida (depende de estado + entrada)
);

    // ------------------------------------------------------------
    // Definición de estados (codificación binaria de 3 bits)
    // ------------------------------------------------------------
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;
    parameter S5 = 3'b101;
    parameter S6 = 3'b110;
    parameter S7 = 3'b111;

    reg [2:0] current_state, next_state;

    // ------------------------------------------------------------
    // Lógica secuencial: registro de estado
    // ------------------------------------------------------------
    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // ------------------------------------------------------------
    // Lógica combinacional: siguiente estado y salida (Mealy)
    // ------------------------------------------------------------
    always @(*) begin
        next_state <= S0;   // valor por defecto

        case (current_state)

            S0: begin
                y_o <= 1'b0;
                if (x_i)
                    next_state <= S0;
                else
                    next_state <= S1;
            end

            S1: begin
                y_o <= 1'b0;
                if (x_i)
                    next_state <= S2;
                else
                    next_state <= S1;
            end

            S2: begin
                y_o <= 1'b0;
                if (x_i)
                    next_state <= S0;
                else
                    next_state <= S3;
            end

            S3: begin
                y_o <= 1'b0;
                if (x_i)
                    next_state <= S0;
                else
                    next_state <= S4;
            end

            S4: begin
                y_o <= 1'b0;
                if (x_i)
                    next_state <= S0;
                else
                    next_state <= S5;
            end

            S5: begin
                y_o <= 1'b0;
                if (x_i)
                    next_state <= S0;
                else
                    next_state <= S6;
            end

            S6: begin
                y_o <= 1'b0;
                if (x_i)
                    next_state <= S0;
                else
                    next_state <= S7;
            end

            S7: begin
                if (x_i) begin
                    next_state <= S0;
                    y_o <= 1'b1;
                end
                else begin
                    next_state <= S1;
                    y_o <= 1'b0;
                end
            end

            default: begin
                next_state <= S0;
                y_o <= 1'b0;
            end

        endcase
    end

endmodule
