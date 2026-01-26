export type Product = {
  id: string;
  name: string;
  description: string;
  price: number;
  image: string;
  category: string;
  inStock: boolean;
};

export const products: Product[] = [
  {
    id: "dundalk-third-2019",
    name: "Dundalk Third Kit 2019",
    description: "Bold dark kit with subtle patterning and bright crest.",
    price: 84,
    image: "/images/shirt-dundalk-2019.jpg",
    category: "Football shirts",
    inStock: true,
  },
  {
    id: "dinamo-minsk-2011",
    name: "Dinamo Minsk 2011 Kit",
    description: "Classic blue kit with clean panel detailing.",
    price: 79,
    image: "/images/shirt-dinamo-minsk-2011.jpg",
    category: "Football shirts",
    inStock: true,
  },
  {
    id: "atl-parana",
    name: "Atl. Parana 2022 Shirt",
    description: "High-contrast stripes with a modern collar shape.",
    price: 88,
    image: "/images/shirt-atl-parana.png",
    category: "Football shirts",
    inStock: true,
  },
  {
    id: "columbus-eagles",
    name: "Columbus Eagles FC Kit",
    description: "Home, away, and keeper variations in one showcase.",
    price: 92,
    image: "/images/shirt-columbus-eagles.png",
    category: "Football shirts",
    inStock: true,
  },
  {
    id: "municipal-2008",
    name: "Municipal 2008 Shirt",
    description: "Vintage red-and-blue kit with classic badge styling.",
    price: 74,
    image: "/images/shirt-municipal-2008.jpg",
    category: "Football shirts",
    inStock: false,
  },
  {
    id: "flamengo-2025",
    name: "Flamengo Pre-game 2025",
    description: "Lightweight training top for warm-ups and matchday.",
    price: 69,
    image: "/images/shirt-flamengo-2025.png",
    category: "Football shirts",
    inStock: true,
  },
];
