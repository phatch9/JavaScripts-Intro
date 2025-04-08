import java.util.HashMap;
import java.util.Map;

public class EvalVisitor extends ExprBaseVisitor<Integer> {
    private final Map<String, Integer> memory = new HashMap<>();

    @Override
    public Integer visitPrintExpr(ExprParser.PrintExprContext ctx) {
        int value = visit(ctx.expr());  // Ensure return a valid integer
        System.out.println(value);
        return value;  // Returning the value instead of `0`
    }
    @Override
    public Integer visitAssign(ExprParser.AssignContext ctx) {
        String id = ctx.ID().getText(); //Get the text of ID
        int value = visit(ctx.expr());
        memory.put(id, value);
        return value;  // Ensure the assignment returns a value
    }

    @Override
    public Integer visitId(ExprParser.IdContext ctx) {
        String id = ctx.ID().getText();
        return memory.getOrDefault(id, 0); 
        // Return the value of the ID in the store if available,
        // or 0 otherwise.
    }

    @Override
    public Integer visitInt(ExprParser.IntContext ctx) {
        return Integer.valueOf(ctx.INT().getText());
    }

    @Override
    public Integer visitMulDiv(ExprParser.MulDivContext ctx) {
        Integer left = visit(ctx.expr(0));
        Integer right = visit(ctx.expr(1));
        if (left == null || right == null) return 0; // Avoid null values
        return (ctx.op.getType() == ExprParser.MUL) ? left * right : left / right;
    }

    @Override
    public Integer visitAddSub(ExprParser.AddSubContext ctx) {
        Integer left = visit(ctx.expr(0));
        Integer right = visit(ctx.expr(1));
        if (left == null || right == null) return 0; // Avoid null values
        return (ctx.op.getType() == ExprParser.ADD) ? left + right : left - right;
    }

    @Override
    public Integer visitParens(ExprParser.ParensContext ctx) {
        return visit(ctx.expr());
    }
}
