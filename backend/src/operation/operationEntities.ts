import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

export enum Type {
	COMPRA = 'Compra',
	VENDA = 'Venda',
}

export enum Product {
	GASOLINA = 'Gasolina',
	ETANOL = 'Etanol',
	DIESEL = 'Diesel',
}

@Entity()
export class Operation {
	@PrimaryGeneratedColumn()
	id!: number;

	@Column({ type: 'enum', enum: Type })
	type!: Type;

	@Column({ type: 'enum', enum: Product })
	product!: Product;

	@Column()
	quantity!: number;
}