/**
* QConditionGroup is an abstract class extended by QAandGroup and QOrGroup to build parenthetical groupings 
* @author  Fred Hays
* @since   2020-02-04
*/
public abstract class QConditionGroup implements QICondition {
    
    public enum LogicalOperator { AND_x, OR_x }

    private static Map<String, String> operatorMap = new Map<String, String>
    {
        'AND_x' => 'AND',
        'OR_x' => 'OR'
    };

    protected List<QICondition> conditions { get; set; }

    protected LogicalOperator operator;

    public Boolean hasConditions {
        get {
            return (this.conditions != null && !this.conditions.isEmpty());
        }
    }

    public QConditionGroup(LogicalOperator operator) {
        this(new List<QICondition>(), operator);
    }

    public QConditionGroup(List<QICondition> conditions, LogicalOperator operator) {
        this.conditions = conditions;
        this.operator = operator;
    }

    public QConditionGroup add(QICondition condition) {
        this.conditions.add(condition);
        return this;
    }

    public String build() {

        String value = '';

        for (QConditionGroup condition : conditions) {
            if (String.isNotEmpty(value))
                value += ' ' + operatorMap.get(operator.name()) + ' ';
            value += condition.build();
        }

        return '(' + value + ')';
    }
}
