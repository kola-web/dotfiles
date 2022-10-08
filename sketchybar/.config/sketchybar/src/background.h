#pragma once
#include "image.h"

struct background {
  bool enabled;
  bool overrides_height;

  int padding_left;
  int padding_right;
  int y_offset;
  uint32_t border_width;
  uint32_t corner_radius;

  CGRect bounds;
  struct image image;
  struct shadow shadow;
  struct rgba_color color;
  struct rgba_color border_color;
};

void background_init(struct background* background);
void background_calculate_bounds(struct background* background, uint32_t x, uint32_t y);

bool background_set_height(struct background* background, uint32_t height);

void background_draw(struct background* background, CGContextRef context);

void background_clear_pointers(struct background* background);
void background_destroy(struct background* background);

void background_serialize(struct background* background, char* indent, FILE* rsp, bool detailed);
bool background_parse_sub_domain(struct background* background, FILE* rsp, struct token property, char* message);
