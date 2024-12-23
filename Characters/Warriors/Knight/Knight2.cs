using Godot;
using System;

public partial class Knight2 : CharacterBody2D
{
	private int health = 5;
	[Export] private Area2D hurtBox;
	[Export] private Area2D upAttackArea;
	[Export] private Area2D downAttackArea;
	[Export] private Area2D straightAttackArea;
	[Export] public NodeFiniteStateMachine stateMachine;

	public override void _Ready()
	{
		hurtBox.BodyEntered += OnHurtBoxArea2DBodyEntered;
		upAttackArea.BodyEntered += OnUpAttackAreaEntered;
		downAttackArea.BodyEntered += OnDownAttackAreaEntered;
		straightAttackArea.BodyEntered += OnStraightAttackAreaEntered;
	}

	private void OnHurtBoxArea2DBodyEntered(Node2D body)
	{
		GD.Print("has been hurt");
	}

	private void OnStraightAttackAreaEntered(Node2D body)
	{

	}
	private void OnUpAttackAreaEntered(Node2D body)
	{

	}
	private void OnDownAttackAreaEntered(Node2D body)
	{

	}
}
