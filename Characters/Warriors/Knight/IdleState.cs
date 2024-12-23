using Godot;

public partial class IdleState : NodeState
{
	[Export]
	private CharacterBody2D characterBody2D;

	[Export]
	private AnimatedSprite2D animatedSprite2D;

	public override void Enter()
	{
		animatedSprite2D.Play("idle");
		GetTree().CreateTimer(2.0).Timeout += () => {EmitSignal(nameof(Transition), "MoveState");};
	}

	public override void Exit()
	{
		animatedSprite2D.Stop();
	}
}
