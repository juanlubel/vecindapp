# Generated by Django 3.0.4 on 2020-04-09 13:07

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('profiles', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Direction',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('via', models.CharField(blank=True, choices=[('Avda', 'Avenida'), ('C', 'Calle'), ('Plz', 'Plaza'), ('Ps', 'Paseo')], default='', max_length=5)),
                ('avenida', models.CharField(max_length=50)),
                ('numero', models.IntegerField()),
                ('portal', models.CharField(blank=True, max_length=5)),
                ('codigoPostal', models.IntegerField()),
                ('poblacion', models.CharField(max_length=50)),
                ('provincia', models.CharField(max_length=50)),
            ],
        ),
        migrations.CreateModel(
            name='Community',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(blank=True, default='', max_length=50, null=True)),
                ('instalaciones', models.CharField(blank=True, choices=[('Piscina', 'Piscina'), ('Parking', 'Parking'), ('Trasteros', 'Trasteros'), ('Jardin', 'Jardin'), ('Parque', 'Parque')], default='', max_length=50, null=True)),
                ('direccion', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to='community.Direction')),
                ('president', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='president', to='profiles.Propietario')),
                ('services', models.ManyToManyField(blank=True, related_name='employed', to='profiles.Servicio')),
            ],
        ),
        migrations.CreateModel(
            name='Apartment',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('piso', models.IntegerField()),
                ('puerta', models.CharField(max_length=5)),
                ('escalera', models.CharField(blank=True, max_length=25)),
                ('numTrastero', models.CharField(blank=True, max_length=25)),
                ('numCochera', models.CharField(blank=True, max_length=25)),
                ('community', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='apartments', to='community.Community')),
                ('owner', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='owner', to='profiles.Propietario')),
                ('renter', models.ManyToManyField(blank=True, related_name='renter', to='profiles.Inquilino')),
            ],
        ),
    ]
