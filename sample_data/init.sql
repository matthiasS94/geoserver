CREATE TABLE public.my_table (
  id SERIAL PRIMARY KEY,
  name TEXT,
  geom geometry(Point, 4326)
);

INSERT INTO public.my_table (name, geom)
VALUES 
  ('Ort A', ST_SetSRID(ST_MakePoint(13.4050, 52.5200), 4326)),
  ('Ort B', ST_SetSRID(ST_MakePoint(11.5820, 48.1351), 4326));
