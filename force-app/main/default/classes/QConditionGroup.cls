/**
* QConditionGroup is an abstract class extended by QAandGroup and QOrGroup to build parenthetical groupings 
* @author  Fred Hays
* @since   2020-02-04
*/
public abstract class QConditionGroup implements QICondition {

    protected List<QICondition> conditions { get; set; }

    protected String operator;

    public Boolean hasConditions {
        get {
            return (this.conditions != null && !this.conditions.isEmpty());
        }
    }

    public QConditionGroup(String operator) {
        this(new List<QICondition>(), operator);
    }

    public QConditionGroup(List<QICondition> conditions, String operator) {
        this.conditions = conditions;
        this.operator = operator;
    }

    public QConditionGroup add(QICondition condition) {
        this.conditions.add(condition);
        return this;
    }

    public String build() {

        String value = '';

        for (QICondition condition : conditions) {
            if (String.isNotEmpty(value)) {
                value += ' ' + operator + ' ';
            }
            value += condition.build();
        }

        return '(' + value + ')';
    }
}
