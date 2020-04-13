/**
* QAndGroup is used to build a SOQL WHERE clause with parenthetical groupings of logical AND operators
* @author  Fred Hays
* @since   2020-02-04
*/
public class QAndGroup extends QConditionGroup {
    public QAndGroup() {
        super(LogicalOperator.AND_x);
    }
    public QAndGroup(List<QICondition> conditions) {
        super(conditions, LogicalOperator.AND_x);
    }
}
