/**
* QBindVariable is used to store apex bind variables (e.g. - WHERE IN :list)
* @author  Fred Hays
* @since   2020-04-15
*/
public class QBindVariable {
	public String bindVar { get; set; }
	
	public QBindVariable(String bindVar) {
		if (!bindVar.startsWith(':')) {
			throw new QBindVariableException('Invalid bind variable. Must begin with colon - :var');
		}
		this.bindVar = bindVar;
	}

	public override String toString() {
		return this.bindVar;
	}
	
	public class QBindVariableException extends Exception {}
}