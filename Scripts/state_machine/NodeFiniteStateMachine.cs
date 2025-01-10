using Godot;
using System.Collections.Generic;

public partial class NodeFiniteStateMachine : Node
{
	[Export]
	private NodeState initialNodeState;

	private NodeState currentNodeState;
	private string currentNodeStateName;
	private Dictionary<string, NodeState> nodeStates = new Dictionary<string, NodeState>();

	public override void _Ready()
	{
		foreach (NodeState nodeState in GetChildren())
		{
			nodeStates[nodeState.Name.ToString().ToLower()] = nodeState;
			/*nodeState.Connect(nameof(nodeState.Trasition), new Callable(this, nameof(TransitionTo)));*/
		}

		if (initialNodeState != null)
			currentNodeState = initialNodeState;
			currentNodeStateName = currentNodeState.Name;
			initialNodeState.Enter();
	}

	public override void _PhysicsProcess(double delta)
	{
		if (currentNodeState != null)
			currentNodeState.OnPhysicsProcess(delta);
	}

	public override void _Input(InputEvent @event)
	{
		if (currentNodeState != null)
			currentNodeState.Input(@event);
	}

    public void TransitionTo(string nodeName)
	{
		if (nodeName.ToLower() == currentNodeStateName.ToLower())
			return;

		var newNodeState = nodeStates[nodeName.ToLower()];
		if (newNodeState == null)
			return;

		if (currentNodeState != null)
			currentNodeState.Exit();

		currentNodeState = newNodeState;
		newNodeState.Enter();
		currentNodeStateName = currentNodeState.Name.ToString().ToLower();
	}
}
