module fsm_light(light,s1,s2,clock,reset,full,empty);
   input s1,s2;
   input clock,reset;
   output light;
   output full,empty;
   reg 	  light;
   reg [3:0] count;
   typedef enum logic [1:0] {IDLE,A,B} State;
   State currentState,nextState;
   
   
   always@(posedge clock or negedge reset) 
     begin
	if(~reset) begin
	   currentState<=IDLE;
	   nextState<=IDLE;
	end
	else
	  currentState<=nextState;
     end
   
   always@(*) begin
      case(currentState)
	IDLE:if(s1)
	  nextState=A;
	else if(s2)
	  nextState=B;
	else
	  nextState=IDLE;
	A:if(s1) 
	  nextState=IDLE;
	else if(s2)
	  nextState=IDLE;
	else 
	  nextState=A;
	B:if(s1)
	  nextState=IDLE;
	else if(s2)
	  nextState=IDLE;
	else
	  nextState=B;
	//	default nextState=currentState;
      endcase // case (currentState)
   end // always@ (s1 or s2)
   
   always@(posedge clock or negedge reset)
     begin
	if(~reset)
	  count<=0;
	case(currentState)
	  A: if(s2)
	    count<=count+1;
	  B: if(s1)
	    count<=count-1;
	endcase
     end
   assign empty=!count;
   assign full=count>14;
   assign light=|count;

endmodule // fsm_light
