using Godot;

public abstract partial class NodeState : Node
{
    [Signal]
    public delegate void TransitionEventHandler(string newNodeName);

    public virtual void Enter()
    {

    }

    public virtual void Input(InputEvent inputValue)
    {

    }

    public virtual void OnPhysicsProcess(double delta)
    {

    }

    public virtual void Exit()
    {

    }
}
