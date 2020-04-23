/**
* QOrder is used to build ORDER BY for SOQL statements
* @author  Jean-Philippe Monette
* @since   2017-03-31
*/
public class QOrder {

    public enum SortOrder { ASCENDING, DESCENDING }
    public enum NullsOrder { FIRST, LAST }

    private String field;
    private SortOrder sortValue;
    private NullsOrder nullsValue;

    public QOrder(String field) {
        this.field = field;
        this.sortValue = SortOrder.ASCENDING;
    }

    public QOrder ascending() {
        this.sortValue = SortOrder.ASCENDING;
        return this;
    }

    public QOrder descending() {
        this.sortValue = SortOrder.DESCENDING;
        return this;
    }

    public QOrder nullsFirst() {
        this.nullsValue = NullsOrder.FIRST;
        return this;
    }

    public QOrder nullsLast() {
        this.nullsValue = NullsOrder.LAST;
        return this;
    }

    public String build() {
        String orderString = field;

        if (sortValue == SortOrder.ASCENDING) {
            orderString += ' ASC';
        } else {
            orderString += ' DESC';
        }

        if (nullsValue != null && nullsValue == NullsOrder.FIRST) {
            orderString += ' NULLS FIRST';
        } else if (nullsValue != null && nullsValue == NullsOrder.LAST) {
            orderString += ' NULLS LAST';
        }

        return orderString;
    }
}