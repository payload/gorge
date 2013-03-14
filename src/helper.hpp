using Vec2 = sf::Vector2f;
using Poly = std::vector<Vec2>;

inline Vec2& normalize(Vec2& v) {
	float len = sqrtf(v.x * v.x + v.y * v.y);
	v /= len;
	return v;
}

inline int randInt(int min, int max) {
	return min + rand() % (max - min + 1);
}
inline float randFloat(float min, float max) {
	return min + rand() / (float)RAND_MAX * (max - min);
}

void drawPoly(sf::RenderWindow& win, const Poly poly);
float checkCollision(const Poly& a, const Poly& b, Vec2* pnormal=nullptr, Vec2* pwhere=nullptr);

template<class T>
void updateList(std::forward_list<std::unique_ptr<T>>& list) {
	auto prevIt = list.before_begin();
	for (auto it = list.begin(); it != list.end(); it++) {
		if (!(*it)->update()) {
			list.erase_after(prevIt);
			it = prevIt;
		}
		else prevIt = it;
	}
}

sf::Texture& loadTexture(const std::string& filename);


