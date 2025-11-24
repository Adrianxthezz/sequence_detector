// ================================================================
// Máquina de Estados de Mealy de 4 estados (2 Flip-Flops)
// ================================================================
// Autor: Adrián Trejo
// Descripción: FSM de Mealy
// ================================================================

module fsm (
    input wire clk_i,       // reloj
    input wire rst_i,       // reset asíncrono activo en bajo
    input wire x_i,         // entrada
    output reg y_o          // salida (depende de estado + entrada)
);

    // ------------------------------------------------------------
    // Definición de estados (codificación binaria de 2 bits)
    // ------------------------------------------------------------
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;
    reg [1:0] current_state, next_state;

    // ------------------------------------------------------------
    // Lógica secuencial: registro de estado (2 flip-flops)
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
        next_state <= S0;
        unique case (current_state)
            S0: begin
                y_o <= 1'b0;  
                if (x_i) begin
                    next_state <= S1;
                end else begin
                    next_state <= S0;
                end
            end

            S1: begin
                y_o <= 1'b0;  
                if (x_i) begin
                    next_state <= S1;
                end else begin
                    next_state <= S2; 
                end
            end

            S2: begin
                y_o <= 1'b0;
                if (x_i) begin
                    next_state <= S1;
                end else begin
                    next_state <= S3;
                end
            end

            S3: begin
                if (x_i) begin
                    next_state <= S1;
                    y_o <= 1'b1;
                end else begin
                    next_state <= S0;
                    y_o <= 1'b0;
                end
            end

            default: begin
                next_state <= S0;
            end
        endcase
    end
    
endmodule
