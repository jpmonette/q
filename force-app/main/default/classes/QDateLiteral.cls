/**
 * Created by fehays on 4/7/2020.
 */

public class QDateLiteral {
    public enum Value {
        YESTERDAY,TODAY,TOMORROW,LAST_WEEK,THIS_WEEK,NEXT_WEEK,LAST_MONTH,THIS_MONTH,NEXT_MONTH,LAST_90_DAYS,
        NEXT_90_DAYS,LAST_N_DAYS,NEXT_N_DAYS,NEXT_N_WEEKS,LAST_N_WEEKS,NEXT_N_MONTHS,LAST_N_MONTHS,THIS_QUARTER,
        LAST_QUARTER,NEXT_QUARTER,NEXT_N_QUARTERS,LAST_N_QUARTERS,THIS_YEAR,LAST_YEAR,NEXT_YEAR,NEXT_N_YEARS,
        LAST_N_YEARS,THIS_FISCAL_QUARTER,LAST_FISCAL_QUARTER,NEXT_FISCAL_QUARTER,NEXT_N_FISCAL_QUARTERS,LAST_N_FISCAL_QUARTERS,
        THIS_FISCAL_YEAR,LAST_FISCAL_YEAR,NEXT_FISCAL_YEAR,NEXT_N_FISCAL_YEARS,LAST_N_FISCAL_YEARS
    }
    public Value literal { get; set; }
    public Integer n { get; set; }

    public QDateLiteral(Value literal, Integer n) {
        this.literal = literal;
        this.n = n;
    }
    public String buildLiteral() {
        return (this.n != null) ? this.literal.name() + ':' + String.valueOf(this.n) : this.literal.name();
    }
}