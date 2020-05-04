/**
* QTypeOf is a class used to build TYPEOF statement in the SELECT statement
* @author  Fred Hays
* @since   2020-04-29
*/

public class QTypeOf {

    // interfaces used to enforce valid method chaining order
    public interface IWhen {
        IThen when(String objectName);
        QTypeOfBuilder otherwise(Set<String> fieldNames);
    }

    public interface IThen {
        IWhen then(Set<String> fieldSet);
    }

    public class QTypeOfBuilder implements IWhen, IThen {

        private String whenFieldName;
        private Set<String> elseFieldNames = new Set<String>();
        private Map<String, Set<String>> whenItems = new Map<String, Set<String>>();
        private String currentObjectName;

        public QTypeOfBuilder(String whenFieldName) {
            this.whenFieldName = whenFieldName;
        }

        public IThen when(String objectName) {
            this.currentObjectName = objectName;
            return this;
        }

        public IWhen then(Set<String> fieldSet) {
            this.whenItems.put(this.currentObjectName, fieldSet);
            return this;
        }

        public QTypeOfBuilder otherwise(Set<String> elseFieldNames) {
            this.elseFieldNames = elseFieldNames;
            return this;
        }

        public String build() {
            String val = 'TYPEOF ' + this.whenFieldName + ' ';
            for (String objectName : this.whenItems.keySet()) {
                val += 'WHEN ' + objectName + ' THEN ' + String.join(new List<String>(this.whenItems.get(objectName)), ',') + ' ';
            }
            if (!this.elseFieldNames.isEmpty()) {
                val += 'ELSE ' + String.join(new List<String>(this.elseFieldNames), ',') + ' ';
            }
            val += 'END';
            return val;
        }
    }
}