package com.element.oimo.physics.util 
{
	import com.element.oimo.math.Mat33;
	import com.element.oimo.math.Mat44;
	import com.element.oimo.math.Quat;
	import com.element.oimo.math.Vec3;
	import com.element.oimo.physics.collision.broad.SweepAndPruneBroadPhase;
	import com.element.oimo.physics.dynamics.World;
	import de.cube3d.serialize.ISerializeInputStream;
	import de.cube3d.serialize.ISerializeOutputStream;
	import de.cube3d.serialize.ISerializer;
	import de.cube3d.serialize.Serializer;
	
	/**
	 * Serializer that can serialize the World class
	 */
	public class PhysicsSerializer implements ISerializer 
	{		
		public function serialize(serializer:ISerializeOutputStream, object:*):void 
		{
			if (object is Vec3) {
				var v3: Vec3 = object as Vec3;
				serializer.write(v3.x);
				serializer.write(v3.y);
				serializer.write(v3.z);
				return;
			}
			if (object is Quat) {
				var q: Quat = object as Quat;
				serializer.write(q.s);
				serializer.write(q.x);
				serializer.write(q.y);
				serializer.write(q.z);
				return;
			}
			if (object is Mat33) {
				var m33: Mat33 = object as Mat33;
				serializer.write(m33.e00);
				serializer.write(m33.e01);
				serializer.write(m33.e02);
				serializer.write(m33.e10);
				serializer.write(m33.e11);
				serializer.write(m33.e12);
				serializer.write(m33.e20);
				serializer.write(m33.e21);
				serializer.write(m33.e22);
				return;
			}
			if (object is Mat44) {
				var m44: Mat44 = object as Mat44;
				serializer.write(m44.e00);
				serializer.write(m44.e01);
				serializer.write(m44.e02);
				serializer.write(m44.e03);
				
				serializer.write(m44.e10);
				serializer.write(m44.e11);
				serializer.write(m44.e12);
				serializer.write(m44.e13);
				
				serializer.write(m44.e20);
				serializer.write(m44.e21);
				serializer.write(m44.e22);
				serializer.write(m44.e23);
				
				serializer.write(m44.e30);
				serializer.write(m44.e31);
				serializer.write(m44.e32);
				serializer.write(m44.e33);
				return;
			}
			object.serialize(serializer.write);
		}
		
		public function deserialize(serializer:ISerializeInputStream, registerFunc:Function, clss:Class):* 
		{
			switch (clss) {
				case World: 
					var world: World = new World();
					registerFunc(world);
					world.deserialize(serializer.read);
					return world;
				case SweepAndPruneBroadPhase:
					var sweepAndPrunePhase: SweepAndPruneBroadPhase = new SweepAndPruneBroadPhase();
					registerFunc(sweepAndPrunePhase);
					return sweepAndPrunePhase;
				case Vec3: 
					return (registerFunc(new Vec3()) as Vec3).init(serializer.read(), serializer.read(), serializer.read());
				case Quat:
					return (registerFunc(new Quat()) as Quat).init(serializer.read(), serializer.read(), serializer.read(), serializer.read());
				case Mat33:
					return (registerFunc(new Mat33()) as Mat33).init(
						serializer.read(), serializer.read(), serializer.read(), 
						serializer.read(), serializer.read(), serializer.read(), 
						serializer.read(), serializer.read(), serializer.read());
				case Mat44:
					return (registerFunc(new Mat44()) as Mat44).init(
						serializer.read(), serializer.read(), serializer.read(), serializer.read(),
						serializer.read(), serializer.read(), serializer.read(), serializer.read(),
						serializer.read(), serializer.read(), serializer.read(), serializer.read(),
						serializer.read(), serializer.read(), serializer.read(), serializer.read());
					
			}
			
		}
		
		public function registerTo(serializer: Serializer): PhysicsSerializer {
			serializer.registerSerializer(World, this);
			serializer.registerSerializer(SweepAndPruneBroadPhase, this);
			serializer.registerSerializer(Vec3, this);
			return this;
		}
		
	}

}