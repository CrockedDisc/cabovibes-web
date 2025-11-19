import type { Service } from "./types";

export const SERVICES: Service[] = [
  {
    title: "Sport Fishing",
    image: "https://vsdvaupohzzibwlvubnq.supabase.co/storage/v1/object/public/Cabovibes/Sport%20fishing%20boats/images/sport-fishing.jpg",
    link: "/sport-fishing",
    alt: "Sport Fishing",
  },
  {
    title: "Sunset & Ballena",
    image: "https://vsdvaupohzzibwlvubnq.supabase.co/storage/v1/object/public/Cabovibes/Sport%20fishing%20boats/images/sunset-ballena.jpg",
    link: "/sunset-ballena",
    alt: "Sunset & Ballena",
  },
  {
    title: "Yacht Chartering",
    image: "https://vsdvaupohzzibwlvubnq.supabase.co/storage/v1/object/public/Cabovibes/Sport%20fishing%20boats/images/yacht-chartering.jpg",
    link: "/yacht-chartering",
    alt: "Yacht Chartering",
  },
] as const;
